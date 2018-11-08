class supervisor::foo {

  file { '/etc/supervisor/conf.d/foo.conf':
    ensure => file,
    source => 'puppet:///modules//supervisor/foo.conf',
    notify => Exec['supervisor-update'],
    require => Service['supervisor']
  }
}