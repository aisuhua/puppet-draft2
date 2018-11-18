class haproxy::reload {

  exec { 'haproxy-reload':
    command => '/usr/sbin/service haproxy reload',
    refreshonly => true,
    require => Service['haproxy']
  }
}