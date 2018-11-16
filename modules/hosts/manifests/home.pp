class hosts::home {

  augeas { 'puppetmaster':
    context => '/files/etc/hosts',
    changes => [
      "set 01/ipaddr 192.168.31.200",
      "set 01/canonical puppetmaster.aisuhua.net",
      "set 01/alias[1] puppetmaster",
    ],
    onlyif => "match *[ipaddr = '192.168.31.200'] size == 0"
  }

  augeas { 'wp-web1':
    context => '/files/etc/hosts',
    changes => [
      "set 01/ipaddr 192.168.31.201",
      "set 01/canonical wp-web1.192.168.1.100.hn1.aisuhua.net",
      "set 01/alias[1] wp-web1",
    ],
    onlyif => "match *[ipaddr = '192.168.31.201'] size == 0"
  }

  augeas { 'wp-web2':
    context => '/files/etc/hosts',
    changes => [
      "set 01/ipaddr 192.168.31.202",
      "set 01/canonical wp-web2.192.168.1.101.hn1.aisuhua.net",
      "set 01/alias[1] wp-web2",
    ],
    onlyif => "match *[ipaddr = '192.168.31.202'] size == 0"
  }

  augeas { 'pre-release1':
    context => '/files/etc/hosts',
    changes => [
      "set 01/ipaddr 192.168.31.210",
      "set 01/canonical pre-release1.192.168.1.200.hn1.aisuhua.net",
      "set 01/alias[1] pre-release1",
    ],
    onlyif => "match *[ipaddr = '192.168.31.210'] size == 0"
  }

  augeas { 'pre-release2':
    context => '/files/etc/hosts',
    changes => [
      "set 01/ipaddr 192.168.31.211",
      "set 01/canonical pre-release2.192.168.1.200.hn1.aisuhua.net",
      "set 01/alias[1] pre-release2",
    ],
    onlyif => "match *[ipaddr = '192.168.31.211'] size == 0"
  }

  augeas { 'lb1':
    context => '/files/etc/hosts',
    changes => [
      "set 01/ipaddr 192.168.31.220",
      "set 01/canonical lb1.192.168.1.111.hn1.aisuhua.net",
      "set 01/alias[1] lb1",
    ],
    onlyif => "match *[ipaddr = '192.168.31.220'] size == 0"
  }

  augeas { 'lb2':
    context => '/files/etc/hosts',
    changes => [
      "set 01/ipaddr 192.168.31.221",
      "set 01/canonical lb2.192.168.1.112.hn1.aisuhua.net",
      "set 01/alias[1] lb2",
    ],
    onlyif => "match *[ipaddr = '192.168.31.221'] size == 0"
  }
}