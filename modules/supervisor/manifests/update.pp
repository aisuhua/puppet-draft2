class supervisor::update {

  # https://github.com/miguno/puppet-supervisor/blob/master/manifests/update.pp
  exec { 'supervisor-update':
    path => '/usr/bin',
    command => 'supervisorctl update',
    refreshonly => true,
    require => Service['supervisor']
  }
}