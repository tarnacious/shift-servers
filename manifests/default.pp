group{ 'puppet': ensure  => present }

node 'elasticsearch'{
  Package {
    require  => Exec['apt-get_update']
  }

  exec { 'apt-get_update':
    command     => '/usr/bin/apt-get update',
  }

  include elasticsearch
}

node 'mybox'{
  Package {
    require  => Exec['apt-get_update']
  }

  exec { 'apt-get_update':
    command     => '/usr/bin/apt-get update',
  }

#  include storm::nimbus
  include redis
  include riak
  include elasticsearch
}
