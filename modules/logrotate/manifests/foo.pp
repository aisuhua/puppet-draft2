class logrotate::foo inherits logrotate {

  file { '/etc/logrotate.d/foo':
    ensure => file,
    source => 'puppet:///modules//logrotate/foo'
  }
}