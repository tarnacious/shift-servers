# Sets up a strom service
# this includes a workaround for http://tinyurl.com/d6cn393
define storm::service() {
  file { "/etc/init.d/${name}":
    ensure  => link,
    target  => '/lib/init/upstart-job',
    require => Package['storm']
  }

  storm::replace{$name: 
    file => "/etc/default/${name}",
    pattern => "ENABLE=.no.",
    replacement => "ENABLE=\"yes\"",
    require => Package['storm']
  }

  service{$name:
    ensure    => running,
    provider  => upstart,
    require   => File["/etc/init.d/${name}"],
    subscribe => File['/etc/storm/storm.yaml']
  }
}

