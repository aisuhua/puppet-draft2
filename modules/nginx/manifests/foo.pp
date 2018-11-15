class nginx::foo {

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
      content => "<?php var_dump(\$_SERVER);?>\n";
    '/www/web/foo/worker.php':
      ensure => file,
      content => '<?php $i = 0; while(true) {echo $i++, PHP_EOL; sleep(1);} ;?>';
    '/www/web/foo/cors_server.php':
      ensure => file,
      source => 'puppet:///modules/nginx/other/code/cors_server.php';
    '/www/web/foo/nginx_cors_server.php':
      ensure => file,
      source => 'puppet:///modules/nginx/other/code/nginx_cors_server.php';
    '/www/web/foo/get_client_ip.php':
      ensure => file,
      source => 'puppet:///modules/nginx/other/code/get_client_ip.php';
    '/www/web/foo/client_ip.php':
      ensure => absent;
  }

  file { '/etc/nginx/sites-enabled/foo.conf':
    ensure => file,
    content => template('nginx/foo.conf.erb'),
    require => Package['nginx'],
    notify => Exec['nginx-reload']
  }
}