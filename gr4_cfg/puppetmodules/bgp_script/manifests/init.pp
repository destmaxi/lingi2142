class bgp_script(
    Integer $id
)
{
    $node_name = lookup("name")

    # Create directory with correct permissions
    file {"/etc/bgp_script":
        ensure => directory,
        owner  => bird,
        group  => bird,
    }

    file {"/etc/bgp_script/ping_BGP.sh":
        require => File["/etc/bgp_script"],
        ensure => file,
        content => template("/templates/bgp_script.conf.erb"),
        owner  => bird,
        group  => bird,
        mode   => 'a+x',
    }

    file {"/etc/bgp_script/check_BGP.sh":
        require => File["/etc/bgp_script"],
        ensure => file,
        content => file("/home/vagrant/lingi2142/router_scripts/check_BGP.sh"),
        owner  => bird,
        group  => bird,
        mode   => 'a+x',
    }

    file {"/etc/bgp_script/ask_if_up.sh":
        require => File["/etc/bgp_script"],
        ensure => file,
        content => file("/home/vagrant/lingi2142/router_scripts/ask_if_up.sh"),
        owner  => bird,
        group  => bird,
        mode   => 'a+x',
    }

    #Start command  when the template is created
    #exec { "script-launch":
    #  require => File[["/etc/script/check_BGP.sh"],["/etc/script/ping_BGP.sh"],["/etc/script/ask_if_up.sh"]], # Force to execute the command after
    #  command => "/home/vagrant/lingi2142/monit_tests/script_launcher.sh",
    #}
}