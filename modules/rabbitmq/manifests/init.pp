class rabbitmq {

  # https://www.rabbitmq.com/install-debian.html#apt
  # https://serverfault.com/questions/789327/update-apt-gpg-key-over-puppet
  # http://mycfg.net/notes/getting-the-full-fingerprint-for-a-gpg-key-for-apt-sources-in-puppet.html
  # apt-key adv --list-public-keys --with-fingerprint --with-colons
  apt::key { 'rabbitmq':
    id => '0A9AF2115F4687BD29803A206B73A36E6026DFCA',
    server => 'hkps.pool.sks-keyservers.net',
  }

  file { '/etc/apt/sources.list.d/bintray.rabbitmq.list':
    ensure => file,
    content => "deb https://dl.bintray.com/rabbitmq/debian xenial main erlang\n",
    require => Apt::Key['rabbitmq']
  }

  exec { 'apt-update-rabbitmq':
    path => '/usr/bin:/bin',
    command => "apt-get update",
    subscribe => File['/etc/apt/sources.list.d/bintray.rabbitmq.list'],
    refreshonly => true
  }

  package { ['rabbitmq-server']:
    ensure => installed,
    require => Exec['apt-update-rabbitmq']
  }

  service { 'rabbitmq-server':
    enable => true,
    ensure => running,
    hasrestart => true,
    hasstatus => true,
    require => Package['rabbitmq-server']
  }
}