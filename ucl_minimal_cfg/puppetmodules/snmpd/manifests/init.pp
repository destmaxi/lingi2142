# Puppet looks in data/node.yaml for snmp automatically
# These variables are now accessible in the template
class snmpd (
    String $agentaddress,
    String $ro_community6,
    String $rw_community6,
    Hash $sys
) {
  # Get name of the node (lookup in data/node.yaml
  $location = lookup("name")

  # Create directory with correct permissions
  file {"/etc/snmp":
    ensure => directory,
    owner  => snmp,
    group  => snmp,
  }
  # Fill the template file and place the result in "/etc/snmp/snmpd.conf"
  file {"/etc/snmp/snmpd.conf":
    require => File["/etc/snmp"],
    ensure => file,
    content => template("/templates/snmpd.conf.erb"),
    owner  => snmp,
    group  => snmp,
  }

  # Start snmpd when the template is created
  exec { "snmpd-launch":
    require => File["/etc/snmp/snmpd.conf"], # Force to execute the command after
    #command => "service snmpd start", # IS THAT REALLY CORRECT ???????
  }
}
