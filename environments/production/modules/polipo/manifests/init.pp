class polipo {

  # $parent_proxy = $config::parent_proxy;

  package { 'polipo':
    ensure => installed;
  }

  notify { 'abc':
    message => lookup('polipo::parent_proxy')
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