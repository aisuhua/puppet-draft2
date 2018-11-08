class nginx::default inherits nginx::config {

  file {
    default:
      group => 'www-data',
      owner => 'www-data',
      require => File['/www/web'];
    '/www/web/default':
      ensure => directory;
    '/www/web/default/index.html':
      ensure => file,
      content => "<center><h1>Hello, World!</h1></center>\n";
    '/www/web/default/index.php':
      ensure => file,
      content => "<?php phpinfo();?>\n";
  }

  file { '/etc/nginx/sites-enabled/default.conf':
    ensure => file,
    content => template('nginx/default.conf.erb'),
    require => Package['nginx'],
    notify => Service['nginx']
  }
}