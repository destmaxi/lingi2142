#https://makina-corpus.com/blog/metier/2016/initiation-a-snmp-avec-python-pysnmp

import time
from pysnmp.hlapi import *
from itertools import izip as zip

USER = 'adminUser'
AUTH_PWD = 'safe_password'
PRIV_PWD = 'safe_password'
#Sending SNMP requests to each router
RMT_HOST = [
            'fd00:300:4:f14::4', #pyth
            'fd00:300:4:f24::2',  #hall
            'fd00:300:4:f16::6', #stev
            'fd00:300:4:e11::1', #carn
            'fd00:300:4:f53::5', #sh1c
            'fd00:300:4:f31::3' #mich
           ]

PORT_NBR = [161,161,161,161,161,161] 
TIME_IN_SEC = 300 #delta of 5 min for calculations

#equivalent to snmpget
def get(host, port, mibs, oids, itfs):
    list_of_res = []
    data = [
        ObjectType(ObjectIdentity(mib, oid, itf)) for mib, oid, itf in zip(mibs, oids, itfs)
    ]
    g = getCmd(SnmpEngine(),
        UsmUserData(USER, authKey=AUTH_PWD, privKey=PRIV_PWD),
        Udp6TransportTarget((host, port)),
        ContextData(),
        *data)

    for (errorIndication, errorStatus, errorIndex, varBinds) in g:
        if errorIndication:
            print(errorIndication)
            return None
        elif errorStatus:
            print('%s at %s' % (
                errorStatus.prettyPrint(),
                errorIndex and varBinds[int(errorIndex) - 1][0] or '?'
                                )
                )
            return None
        else:
            for varBind in varBinds:
                list_of_res.append(str(varBind[1]))
    return list_of_res
    

#equivalent to snmpwalk
def walk(host, port, mib, oid):
    list_of_res = []
    g = nextCmd(SnmpEngine(),
        UsmUserData(USER, authKey=AUTH_PWD, privKey=PRIV_PWD),
        Udp6TransportTarget((host, port)),
        ContextData(),
        ObjectType(ObjectIdentity(mib, oid)),
        lexicographicMode=False)
    
    for (errorIndication, errorStatus, errorIndex, varBinds) in g:
        if errorIndication:
            print(errorIndication)
            return None
        elif errorStatus:
            print('%s at %s' % (
                errorStatus.prettyPrint(),
                errorIndex and varBinds[int(errorIndex) - 1][0] or '?'
                                )
                )
            return None
        else:
            for varBind in varBinds:
                list_of_res.append(str(varBind[1]))
    return list_of_res

def get_list_of_itfs(hosts, ports):
    list_of_res = {}
    mib = 'IF-MIB'
    ind_oid = 'ifIndex'
    descr_oid = 'ifDescr'

    for h, p in zip(hosts, ports):
        oid_list = {}
        for x, y in zip(walk(h, p, mib, ind_oid),walk(h, p, mib, descr_oid)):
            oid_list[x] = y
        list_of_res[h] = oid_list
    return list_of_res

def get_list_of_itfs_nbr(itfs):
    list_of_res = []
    for host in RMT_HOST:
        list_of_res.append(itfs[host].keys())
    return list_of_res

def get_list_of_datas(hosts, ports, itfs):
    list_of_res = {}
    for i in range(0, len(hosts)):
        list_of_res_for_one_router = {}
        for j in itfs[i]:
            list_of_res_for_one_router[j] = get_data_of_itf(hosts[i],ports[i],j)
        list_of_res[hosts[i]] = list_of_res_for_one_router
    return list_of_res

def get_data_of_itf(host, port, itf):
    mib = 'IF-MIB'
    isUp = str(get(host, port, [mib], ['ifOperStatus'], [itf])[0])
    if isUp != 'up':
        lastChange = str(get(host, port, [mib], ['ifLastChange'], [itf])[0])
        strRes = "Interface "+str(itf)+" from "+str(host)+" is "+str(isUp)+" since "+str(lastChange)
        return strRes

    mib_tab = [mib, mib, mib, mib, mib, mib, mib]
    itf_tab = [itf, itf, itf, itf, itf, itf, itf]
    oid_tab = ['ifInOctets', 'ifOutOctets', 'ifInErrors', 'ifOutErrors', 'ifInDiscards', 'ifOutDiscards', 'ifSpeed']

    return get(host, port, mib_tab, oid_tab, itf_tab)

def compute_results(old_values, new_values, inIndex, outIndex):
    deltas = compute_deltas(old_values, new_values, inIndex, outIndex)
    return apply_formula(deltas)

def compute_deltas(old_values, new_values, inIndex, outIndex):
    #print("old_values", old_values)
    list_of_res = {}
    for host in new_values.keys():
        list_of_for_one_itf = {}
        for itf in new_values[host].keys():
            if type(new_values[host][itf]) is str: #could be a string if interface is not up (see get_data_of_itf)
                list_of_for_one_itf[itf] = [new_values[host][itf]]
            else:
                list_of_for_one_itf[itf] = [
                    float(new_values[host][itf][inIndex])-float(old_values[host][itf][inIndex]),
                    float(new_values[host][itf][outIndex])-float(old_values[host][itf][outIndex]),
                    float(new_values[host][itf][6]) #speed index
                ]
        list_of_res[host] = list_of_for_one_itf
    return list_of_res

def apply_formula(results):
    """Applying calculation formula according to
    https://support.solarwinds.com/Success_Center/Network_Performance_Monitor_(NPM)/Knowledgebase_Articles/Calculate_interface_bandwidth_utilization """
    list_of_res = {}
    for host, values in results.items():
        list_of_for_one_itf = {}
        for itf, itf_values in values.items():
            in_and_out = []
            for i in range(0,len(itf_values)-1): #skipping the speed index
                if type(itf_values) is str: #could be a string if interface is not up (see get_data_of_itf)
                    in_and_out.append(itf_values)
                else:
		    if itf_values[len(itf_values)-1]==0.0:
		        cal = "Speed problem"
                    else:
                        cal = (itf_values[i]*8*100)/(TIME_IN_SEC*itf_values[len(itf_values)-1])
                    in_and_out.append(cal)
            list_of_for_one_itf[itf] = in_and_out
        list_of_res[host] = list_of_for_one_itf
    return list_of_res

def printer(tab):
    for i in range(0,len(tab)):
	print(tab[i])
        print("\n")


if __name__ == '__main__':
    list_of_itfs = get_list_of_itfs(RMT_HOST, PORT_NBR)
    list_of_itfs_nbr = get_list_of_itfs_nbr(list_of_itfs)
    first_datas = get_list_of_datas(RMT_HOST, PORT_NBR, list_of_itfs_nbr)
    time.sleep(TIME_IN_SEC)
    second_data = get_list_of_datas(RMT_HOST, PORT_NBR, list_of_itfs_nbr)

    #printing the different results

    #legend
    print("----------LEGEND----------")
    printer(str(list_of_itfs).split('}, '))

    #bandwith
    print("----------BANDWIDTH----------")
    printer(str(compute_results(first_datas, second_data, 0, 1)).split('}, '))

    #errors
    print("----------ERRORS----------")
    printer(str(compute_results(first_datas, second_data, 2, 3)).split('}, '))

    #discarded packets
    print("----------DISCARDED PACKETS----------")
    printer(str(compute_results(first_datas, second_data, 4, 5)).split('}, '))
