# Puppet looks in data/node.yaml for snmp automatically
# These variables are now accessible in the template
class snmpd () {
  # Get name of the node (lookup in data/node.yaml
  $location = lookup("name")

  # Create directory with correct permissions
  file {"/etc/snmp":
    ensure => directory,
    owner  => bird,
    group  => bird,
  }
  # Fill the template file and place the result in "/etc/snmp/snmpd.conf"
  file {"/etc/snmp/snmpd.conf":
    require => File["/etc/snmp"],
    ensure => file,
    content => template("/templates/snmpd.conf.erb"),
    owner  => bird,
    group  => bird,
  }

  file {"/etc/snmp/snmp.conf":
    require => File["/etc/snmp"],
    ensure => file,
    content => template("/templates/snmp.conf.erb"),
    owner  => bird,
    group  => bird,
  }

  # Start snmpd when the template is created
  exec { "snmpd-launch":
    require => File[["/etc/snmp/snmpd.conf"],["/etc/snmp/snmp.conf] # Force to execute the command after
    command => "snmpd",
  }
}
