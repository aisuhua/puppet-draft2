class logrotate {

  package { 'logrotate':
    ensure => installed
  }

  contain logrotate::config
}
