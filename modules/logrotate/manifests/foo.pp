class logrotate::foo inherits logrotate::config {

  file { '/etc/logrotate.d/foo':
    ensure => file,
    source => 'puppet:///modules//logrotate/foo'
  }
}