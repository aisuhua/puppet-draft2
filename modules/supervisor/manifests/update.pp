class supervisor::update {

  exec { 'supervisor-update':
    path => '/usr/bin',
    command => '/usr/bin/supervisorctl update',
    refreshonly => true,
    require => Service['supervisor']
  }
}