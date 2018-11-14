class nginx::config {

  File {
    require => Package['nginx'],
    notify => Service['nginx']
  }

  # file { '/etc/nginx/sites-enabled/default':
  #   ensure => absent,
  #   require => Package['nginx'],
  #   notify => Service['nginx']
  # }

  # conf.d
  file { '/etc/nginx/conf.d/upstream.conf':
    ensure => file,
    source => 'puppet:///modules/nginx/conf.d/upstream.conf';
  }

  # snippets
  file {
    '/etc/nginx/snippets/headers.conf':
      ensure => file,
      content => template('nginx/snippets/headers.conf.erb');
    '/etc/nginx/snippets/status.conf':
      ensure => file,
      source => 'puppet:///modules/nginx/snippets/status.conf';
    '/etc/nginx/snippets/cors.conf':
      ensure => file,
      content => template('nginx/snippets/cors.conf.erb');
    '/etc/nginx/snippets/pre_release.conf':
      ensure => file,
      content => template('nginx/snippets/pre_release.conf.erb')
  }

  # nginx.conf
  file { '/etc/nginx/nginx.conf':
    ensure => file,
    source => 'puppet:///modules/nginx/nginx.conf'
  }
}