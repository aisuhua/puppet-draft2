class php72::config {

  # 优化 php.ini 配置
  augeas { 'fpm/php.ini':
    context => '/files/etc/php/7.2/fpm/php.ini/PHP',
    changes => [
      "set upload_max_filesize 30M",
      "set post_max_size 30M",
    ],
    require => Package['php7.2-fpm'],
    notify => Service['php7.2-fpm']
  }

  augeas { 'cli/php.ini':
    context => '/files/etc/php/7.2/cli/php.ini/PHP',
    changes => [
      "set upload_max_filesize 30M",
      "set post_max_size 30M",
    ],
    require => Package['php7.2-cli']
  }

  # 优化 PHP-FPM 配置
  augeas { 'www.conf':
    context => '/files/etc/php/7.2/fpm/pool.d/www.conf/www',
    changes => [
      "set user www-data",
      "set group www-data",
      "set listen 127.0.0.1:9000",
      "set listen.owner www-data",
      "set listen.group www-data",
      "set pm static",
      "set pm.max_children 200",
      "set pm.max_requests 200",
      "set pm.status_path /phpfpm_status",
      "set ping.path /phpfpm_ping",
      "set chdir /",
      # "set slowlog /var/log/phpfpm_slow.log",
      # "set request_slowlog_timeout 1s",
      # "set request_terminate_timeout 0",
    ],
    require => Package['php7.2-fpm'],
    notify => Service['php7.2-fpm']
  }
}