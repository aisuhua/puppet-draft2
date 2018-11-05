class base {

  # 添加本地域名解析
  # http://perlstalker.vuser.org/blog/2012/08/28/managing-etc-hosts-with-puppet/
  augeas { "hosts":
    context => '/files/etc/hosts',
    changes => [
      "set 01/ipaddr 172.16.0.1",
      "set 01/canonical www.example.com",
      "set 01/alias[1] www.example.net",
      "set 01/alias[2] www.example.cn",
    ],
    onlyif => "match *[ipaddr = '172.16.0.1'] size == 0"
  }

  # 给用户授予 sudo 权限
  # https://puppet.com/docs/puppet/5.5/resources_augeas.html#paths-for-numbered-items
  augeas { "sudoers":
    context => '/files/etc/sudoers',
    changes => [
      "set spec[user = 'suhua']/user suhua",
      "set spec[user = 'suhua']/host_group/host ALL",
      "set spec[user = 'suhua']/host_group/command ALL",
      "set spec[user = 'suhua']/host_group/command/runas_user ALL",
      "set spec[user = 'suhua']/host_group/command/runas_group ALL",
      "set spec[user = 'suhua']/host_group/command/tag NOPASSWD",
    ]
  }

  # 修改 ssh 配置
  augeas { "sshd_config":
    context => '/files/etc/ssh/sshd_config',
    changes => [
      "set Port 25680",
      "set PermitRootLogin yes",
    ]
  }

  # 优化系统内核参数
  augeas { "sysctl.conf":
    context => '/files/etc/sysctl.conf',
    changes => [
      "set vm.swappiness 0",
      "set net.ipv4.neigh.default.gc_stale_time 120",
      "set net.ipv4.conf.all.rp_filter 0",
      "set net.ipv4.conf.default.rp_filter 0",
      "set net.ipv4.conf.default.arp_announce 2",
      "set net.ipv4.conf.lo.arp_announce 2",
      "set net.ipv4.conf.all.arp_announce 2",
      "set net.ipv4.tcp_max_tw_buckets 5000",
      "set net.ipv4.tcp_syncookies 1",
      "set net.ipv4.tcp_max_syn_backlog 1024",
      "set net.ipv4.tcp_synack_retries 2",
      "set net.ipv6.conf.all.disable_ipv6 1",
      "set net.ipv6.conf.default.disable_ipv6 1",
      "set net.ipv6.conf.lo.disable_ipv6 1",
      "set kernel.sysrq 1",
      "set net.ipv4.tcp_tw_reuse 1",
      "set net.ipv4.tcp_tw_recycle 1",
      "set net.ipv4.ip_local_port_range '1024 65535'",
      "set net.core.somaxconn 1024",
      "set fs.file-max 655350",
    ]
  }

  # 增加文件描述符限制
  # https://puppet.com/docs/puppet/5.5/resources_augeas.html#etcsecuritylimitsconf
  limits::conf {
    'root-soft':
      domain => root,
      type => soft,
      item => nofile,
      value => 65535;
    'root-hard':
      domain => root,
      type => hard,
      item => nofile,
      value =>  65535;
    '*-soft':
      domain => '*',
      type => soft,
      item => nofile,
      value =>  65535;
    '*-hard':
      domain => '*',
      type => hard,
      item => nofile,
      value =>  65535;
  }

  # 增加文件描述符限制
  file { '/etc/systemd/system.conf':
    ensure => file,
    source  => 'puppet:///modules/base/system.conf',
  }

  # 优化 php.ini 配置
  augeas { "fpm/php.ini":
    context => '/files/etc/php/7.2/fpm/php.ini/PHP',
    changes => [
      "set upload_max_filesize 30M",
      "set post_max_size 30M",
    ]
  }

  augeas { "cli/php.ini":
    context => '/files/etc/php/7.2/cli/php.ini/PHP',
    changes => [
      "set upload_max_filesize 30M",
      "set post_max_size 30M",
    ]
  }

  # 优化 PHP-FPM 配置
  augeas { "www.conf":
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
    ]
  }
}
