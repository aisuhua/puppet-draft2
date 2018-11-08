class supervisor {

  package { 'supervisor':
    ensure => installed
  }

  file { '/etc/supervisor/supervisord.conf':
    ensure => file,
    source => 'puppet:///modules/supervisor/supervisord.conf',
    require => Package['supervisor'],
    notify => Service['supervisor']
  }

  service { 'supervisor':
    enable => true,
    ensure => running,
    hasrestart => true,
    hasstatus => true
  }
}
