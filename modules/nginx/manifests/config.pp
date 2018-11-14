class nginx::config {

  # file { '/etc/nginx/sites-enabled/default':
  #   ensure => absent,
  #   require => Package['nginx'],
  #   notify => Service['nginx']
  # }

  # conf.d
  file { '/etc/nginx/conf.d/upstream.conf':
    ensure => file,
    source => 'puppet:///modules/nginx/conf.d/upstream.conf',
    require => Package['nginx'],
    notify => Service['nginx']
  }

  # snippets
  file { '/etc/nginx/snippets/headers.conf':
    ensure => file,
    content => template('nginx/snippets/headers.conf.erb'),
    require => Package['nginx'],
    notify => Service['nginx']
  }

  file { '/etc/nginx/snippets/status.conf':
    ensure => file,
    source => 'puppet:///modules/nginx/snippets/status.conf',
    require => Package['nginx'],
    notify => Service['nginx']
  }

  file { '/etc/nginx/snippets/cors.conf':
    ensure => file,
    content => template('nginx/snippets/cors.conf.erb'),
    require => Package['nginx'],
    notify => Service['nginx']
  }

  file { '/etc/nginx/snippets/pre_release.conf':
    ensure => file,
    content => template('nginx/snippets/pre_release.conf.erb'),
    require => Package['nginx'],
    notify => Service['nginx']
  }

  # nginx.conf
  file { '/etc/nginx/nginx.conf':
    ensure => file,
    source => 'puppet:///modules/nginx/nginx.conf',
    require => Package['nginx'],
    notify => Service['nginx']
  }
}