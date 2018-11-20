class nginx::demo {

  file {
    default:
      group => 'www-data',
      owner => 'www-data',
      require => File['/www/web'];
    '/www/web/demo':
      ensure => directory;
    '/www/web/demo/index.html':
      ensure => file,
      content => "<center><h1>demo</h1></center>\n";
    '/www/web/demo/index.php':
      ensure => file,
      content => "<?php echo 'demo';?>\n";
    '/www/web/demo/cors_client.html':
      ensure => file,
      source => 'puppet:///modules/nginx/other/code/cors_client.html';
    '/www/web/demo/nginx_cors_client.html':
      ensure => file,
      source => 'puppet:///modules/nginx/other/code/nginx_cors_client.html';
    '/www/web/demo/get_client_ip.php':
      ensure => file,
      source => 'puppet:///modules/nginx/other/code/get_client_ip.php';
    '/www/web/demo/db_proxy.php':
      source => 'puppet:///modules/nginx/other/code/db_proxy.php';
  }

  file { '/etc/nginx/sites-enabled/demo.conf':
    ensure => file,
    content => template('nginx/demo.conf.erb'),
    require => Package['nginx'],
    notify => Exec['nginx-reload']
  }
}