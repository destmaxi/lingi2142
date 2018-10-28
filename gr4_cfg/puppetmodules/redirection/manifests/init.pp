# Puppet looks in data/node.yaml for firewall::interface, firewall::state and firewall::prefix automatically
# These variables are now accessible in the template
class redirection(
)
{

  $id = lookup("id")  
  # Create directory with correct permissions
  file {"/etc/redirection":
    ensure => directory,
    owner  => bird,
    group  => bird,
  }
  # Fill the template file and place the result in "/etc/redirection/redirection.conf"
  file {"/etc/redirection/redirection.sh":
    require => File["/etc/redirection"],
    ensure => file,
    content => template("/templates/redirection.conf.erb"),
    owner  => bird,
    group  => bird,
    mode   => 'a+x',
  }

  # Start bird6 when the template is created
  exec { "redirection-launch":
    require => File["/etc/redirection/redirection.sh"], # Force to execute the command after
    command => "/etc/redirection/redirection.sh >> /etc/redirection/log_redirection &",
  }
}
