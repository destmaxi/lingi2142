# Puppet looks in data/node.yaml for firewall::interface, firewall::state and firewall::prefix automatically
# These variables are now accessible in the template
class script(
  Integer $id
)
{

  $node_name = lookup("name")

  $prefix_a = "fd00:300"
  $prefix_b = "fd00:200"
  $hall = 2
  $hall_link=[ '0f25', '0f24' ]
  $pyth = 4
  $pyth_link=[ '0f14', '0f24', '0f64' ]
  $stev = 6
  $stev_link=[ '0f16', '0f64' ]
  $carn = 1
  $carn_link=[ '0f16', '0f31', '0f14' ]
  $mich = 3
  $mich_link=[ '0f53', '0f31' ]
  $sh1c = 5
  $sh1c_link=[ '0f53', '0f25' ]


  # Create directory with correct permissions
  file {"/etc/script":
    ensure => directory,
    owner  => bird,
    group  => bird,
  }
  # Fill the template file and place the result in "/etc/firewall/firewall.conf"
  file {"/etc/script/script.sh":
    require => File["/etc/script"],
    ensure => file,
    content => template("/templates/script.conf.erb"),
    owner  => bird,
    group  => bird,
    mode   => 'a+x',
  }

  # Start bird6 when the template is created
  exec { "script-launch":
    require => File["/etc/script/script.sh"], # Force to execute the command after
    command => "/etc/script/script.sh",
  }
}
