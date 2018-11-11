class sysctl {

  augeas { 'sysctl.conf':
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

  exec { 'sysctl':
    path => '/sbin',
    command => 'sysctl -p',
    refreshonly => true,
    subscribe => Augeas["sysctl.conf"]
  }
}