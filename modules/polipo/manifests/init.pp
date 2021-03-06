class polipo {

  package { 'polipo':
    ensure => installed;
  }

  file { '/etc/polipo/config':
    ensure => file,
    content => template('polipo/conf.erb'),
    require => Package['polipo'],
    notify => Service['polipo'],
  }

  service { 'polipo':
    enable => true,
    ensure => running,
    hasrestart => true,
    hasstatus => true,
    require => Package['polipo']
  }
}