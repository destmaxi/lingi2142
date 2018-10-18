# Puppet looks in data/node.yaml for firewall::interface, firewall::state and firewall::prefix automatically
# These variables are now accessible in the template
class firewall (
  String $interface,
  String $wrong_prefix,
  String $type
) {

  $router_name = lookup("name")
  $prefix_a = "fd00:300:4"
  $prefix_b = "fd00:200:4"

  # Create directory with correct permissions
  file {"/etc/firewall":
    ensure => directory,
    owner  => bird,
    group  => bird,
  }
  # Fill the template file and place the result in "/etc/firewall/firewall.conf"
  file {"/etc/firewall/firewall.sh":
    require => File["/etc/firewall"],
    ensure => file,
    content => template("/templates/firewall.conf.erb"),
    owner  => bird,
    group  => bird,
    mode   => 'a+x',
  }

  # Start bird6 when the template is created
  exec { "firewall-launch":
    require => File["/etc/firewall/firewall.sh"], # Force to execute the command after
    command => "/etc/firewall/firewall.sh",
  }
}
