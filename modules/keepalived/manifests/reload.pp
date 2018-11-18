class keepalived::reload {

  exec { 'keepalived-reload':
    command => '/usr/sbin/service keepalived reload',
    refreshonly => true,
    require => Service['keepalived']
  }
}