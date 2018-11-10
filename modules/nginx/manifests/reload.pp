class nginx::reload {

  exec { 'nginx-reload':
    path => '/usr/sbin',
    command => 'nginx -s reload',
    refreshonly => true,
    require => Service['nginx']
  }
}