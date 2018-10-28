# Puppet looks in data/node.yaml for firewall::interface, firewall::state and firewall::prefix automatically
# These variables are now accessible in the template
class static_routes (
  Array $interfaces
) {
  $id = lookup("id")
  $prefix_a = "fd00:300"
  $prefix_b = "fd00:200"

  # Create directory with correct permissions
  file {"/etc/static_routes":
    ensure => directory,
    owner  => bird,
    group  => bird,
  }
  # Fill the template file and place the result in "/etc/firewall/firewall.conf"
  file {"/etc/static_routes/static_routes.sh":
    require => File["/etc/static_routes"],
    ensure => file,
    content => template("/templates/static_routes.conf.erb"),
    owner  => bird,
    group  => bird,
    mode   => 'a+x',
  }

  # Start bird6 when the template is created
  exec { "static_routes-launch":
    require => File["/etc/static_routes/static_routes.sh"], # Force to execute the command after
    command => "/etc/static_routes/static_routes.sh",
  }
}
