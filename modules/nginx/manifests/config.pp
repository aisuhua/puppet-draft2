class nginx::config {

  # file { '/etc/nginx/sites-enabled/default':
  #   ensure => absent,
  #   require => Package['nginx'],
  #   notify => Service['nginx']
  # }

  file { '/etc/nginx/sites-enabled/default':
    ensure => file,
    source => 'puppet:///modules/nginx/default/default',
    require => Package['nginx'],
    notify => Service['nginx']
  }

  file { '/etc/nginx/conf.d/upstream.conf':
    ensure => file,
    source => 'puppet:///modules/nginx/upstream.conf',
    require => Package['nginx'],
    notify => Service['nginx']
  }

  file { '/etc/nginx/snippets/headers.conf':
    ensure => file,
    content => template('nginx/headers.conf.erb'),
    require => Package['nginx'],
    notify => Service['nginx']
  }

  file { '/etc/nginx/snippets/status.conf':
    ensure => file,
    source => 'puppet:///modules/nginx/status.conf',
    require => Package['nginx'],
    notify => Service['nginx']
  }

  file { '/etc/nginx/snippets/cors.conf':
    ensure => file,
    source => 'puppet:///modules/nginx/cors.conf',
    require => Package['nginx'],
    notify => Service['nginx']
  }

  file { '/etc/nginx/snippets/prerelease.conf':
    ensure => file,
    content => template('nginx/prerelease.conf.erb'),
    require => Package['nginx'],
    notify => Service['nginx']
  }

  file { '/etc/nginx/nginx.conf':
    ensure => file,
    source => 'puppet:///modules/nginx/nginx.conf',
    require => Package['nginx'],
    notify => Service['nginx']
  }
}