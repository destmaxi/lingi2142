import time
from pysnmp.hlapi import *
from itertools import izip as zip

USERNAME = 'adminUser'
AUTH_KEY = 'safe_password'
PRIV_KEY = 'safe_password'

IN_BAND, OUT_BAND, SPEED = 0, 1, 2
IN_DISC, OUT_DISC = 3, 4
IN_ERRO, OUT_ERRO = 5, 6
IN_PROT = 7



### ATTENTION DIVISION DOUBLE/INTEGER (mult le deno par 1.0)


def get_single_router_single_interface_datas(remote_host, port_number, interface_number):
    operStatus = str(get(remote_host, port_number, ['IF-MIB'], ['ifOperStatus'], [interface_number])[0])
    if operStatus == 'up':
        return get(remote_host, port_number, ['IF-MIB' for i in range(0,8)],
                    ['ifInOctets', 'ifOutOctets', 'ifSpeed', 'ifInDiscards', 'ifOutDiscards', 'ifInErrors',
                        'ifOutErrors', 'ifInUnknownProtos'],
                    [interface_number for i in range(0,8)])
    else:
        return '{} since {}'.format(operStatus,
                                get(remote_host, port_number, ['IF-MIB'], ['ifLastChange'], [interface_number])[0])

def get_single_router_all_interfaces_datas(remote_host, port_number, interfaces_numbers):
    """ Return a dictionary with one entry per interface. """
    return {k: get_single_router_single_interface_datas(remote_host, port_number, k) for k in interfaces_numbers}

def get_all_routers_all_interfaces_datas(remotes_host, ports_number, interfaces_numbers):
    """ Return a dictionary with one entry per remote_host. """
    return {remotes_host[i]: get_single_router_all_interfaces_datas(remotes_host[i], ports_number[i], \
            interfaces_numbers[i]) for i in range(0, len(remotes_host))}

def get_all_routers_all_interfaces_deltas(old_datas, new_datas, IN, OUT):
    if(OUT != None):
        return {host: {itf: (int(new_datas[host][itf][IN]) - int(old_datas[host][itf][IN]),
                            int(new_datas[host][itf][OUT]) - int(old_datas[host][itf][OUT]),
                            int(new_datas[host][itf][SPEED]))
                            if type(new_datas[host][itf]) is not str else new_datas[host][itf]
                        for itf in new_datas[host].keys()}
                    for host in new_datas.keys()}
    else:
        return {host: {itf: (int(new_datas[host][itf][IN]) - int(old_datas[host][itf][IN]),
                            int(new_datas[host][itf][SPEED]))
                            if type(new_datas[host][itf]) is not str else new_datas[host][itf]
                        for itf in new_datas[host].keys()}
                    for host in new_datas.keys()}

def compute_proportions(deltas, timeout_in_seconds):

    return {host: {itf: tuple((itf_datas[i] * 800)/(timeout_in_seconds * itf_datas[len(itf_datas) - 1])
                                for i in range(0, len(itf_datas) - 1))
                        if type(itf_datas) is not str else itf_datas
                for itf, itf_datas in host_datas.items()}
            for host, host_datas in deltas.items()}

def walk(remote_host, port_number, mib, ressource):
    result = []
    for (errorIndication, errorStatus, errorIndex, varBinds) in nextCmd(SnmpEngine(),
            UsmUserData(USERNAME, authKey=AUTH_KEY, privKey=PRIV_KEY),
            Udp6TransportTarget((remote_host, port_number)),
            ContextData(),
            ObjectType(ObjectIdentity(mib, ressource)),
            lexicographicMode=False):
        if errorIndication:
            print(errorIndication)
            return None
        elif errorStatus:
            print('%s at %s' % (errorStatus.prettyPrint(),
                    errorIndex and varBinds[int(errorIndex) - 1][0] or '?'))
            return None
        else:
            for varBind in varBinds:
                result.append(str(varBind[1]))
    return result

def get(remote_host, port_number, mibs, ressources, interfaces_number):
    results = []
    objects_datas = [ObjectType(ObjectIdentity(mib, res, itf)) for mib, res, itf in zip(mibs, ressources, interfaces_number)]

    for errorIndication, errorStatus, errorIndex, varBinds in getCmd(SnmpEngine(),
                                        UsmUserData(USERNAME, authKey=AUTH_KEY, privKey=PRIV_KEY),
                                        Udp6TransportTarget((remote_host, port_number)),
                                        ContextData(), *objects_datas):
        if errorIndication:
            print(errorIndication)
            return None
        elif errorStatus:
            print('%s at %s' % (
                    errorStatus.prettyPrint(),
                    errorIndex and varBinds[int(errorIndex) - 1][0] or '?'))
            return None
        else:
            for varBind in varBinds:
                results.append(str(varBind[1])) #0: clefs , 1:valeur
    return results


def list_all_routers_all_interfaces(remotes_host, ports_number):
    return {host: {k: v for k, v in zip(walk(host, port, 'IF-MIB', 'ifIndex'),
                                        walk(host, port, 'IF-MIB', 'ifDescr'))}
                for host, port in zip(remotes_host, ports_number)}


def transform_pretty_mapping(old_datas, new_datas, timeout_in_seconds, IN, OUT):
    deltas = get_all_routers_all_interfaces_deltas(old_datas, new_datas, IN, OUT)
    ugly_mapping = compute_proportions(deltas, timeout_in_seconds)
    return {host: {interfaces_mapping[host][itf]: ugly_mapping[host][itf]
                    for itf in ugly_mapping[host].keys()}
                for host in ugly_mapping.keys()}


if __name__ == '__main__':
    remotes_host, ports_number, timeout_in_seconds = ['localhost','fd00:300:4:f16::6'], [161,161], 10
    interfaces_mapping = list_all_routers_all_interfaces(remotes_host, ports_number)
    #print(str(interfaces_mapping))
    interfaces_number = [host_datas.keys() for host_datas in interfaces_mapping.values()]
    #print(str(interfaces_number))
    old_datas = get_all_routers_all_interfaces_datas(remotes_host, ports_number, interfaces_number)
    #print(str(old_datas))
    time.sleep(timeout_in_seconds)
    new_datas = get_all_routers_all_interfaces_datas(remotes_host, ports_number, interfaces_number)
    print('Bandwidth: {}\n'.format(transform_pretty_mapping(old_datas, new_datas, timeout_in_seconds, IN_BAND, OUT_BAND)))
    print('Discards: {}\n'.format(transform_pretty_mapping(old_datas, new_datas, timeout_in_seconds, IN_DISC, OUT_DISC))) #paquets corrects mais volontairement discard (ex : plus de place, deja en cache,...)
    print('Errors: {}\n'.format(transform_pretty_mapping(old_datas, new_datas, timeout_in_seconds, IN_ERRO, OUT_ERRO))) #passage layer du dessus fail
    print('Protocols: {}\n'.format(transform_pretty_mapping(old_datas, new_datas, timeout_in_seconds, IN_PROT, None))) #erreur de mauvais protocol

