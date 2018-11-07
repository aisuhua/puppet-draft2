class nginx::default {

  file {
    default:
      group => 'www-data',
      owner => 'www-data';
    '/www/web/default':
      ensure => directory;
    '/www/web/default/index.html':
      ensure => file,
      content => '<center><h1>Hello, World!</h1></center>';
    '/www/web/default/index.php':
      ensure => file,
      content => '<?php phpinfo();?>';
  }

  file { '/etc/nginx/sites-enabled/default.conf':
    ensure => file,
    source => 'puppet:///modules/nginx/default.conf',
    require => Package['nginx'],
    notify => Service['nginx']
  }
}