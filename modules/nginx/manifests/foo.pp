class nginx::foo inherits nginx::config {

  file {
    default:
      group => 'www-data',
      owner => 'www-data',
      require => File['/www/web'];
    '/www/web/foo':
      ensure => directory;
    '/www/web/foo/index.html':
      ensure => file,
      content => "<center><h1>Hello, World!</h1></center>\n";
    '/www/web/foo/index.php':
      ensure => file,
      content => "<?php phpinfo();?>\n";
  }

  file { '/etc/nginx/sites-enabled/foo.conf':
    ensure => file,
    content => template('nginx/foo.conf.erb'),
    require => Package['nginx'],
    notify => Service['nginx']
  }
}