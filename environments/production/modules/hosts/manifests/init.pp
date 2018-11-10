class hosts {

  augeas { 'puppetmaster':
    context => '/files/etc/hosts',
    changes => [
      "set 01/ipaddr 192.168.31.220",
      "set 01/canonical puppetmaster.aisuhua.net",
      "set 01/alias[1] puppetmaster",
    ],
    onlyif => "match *[ipaddr = '192.168.31.220'] size == 0"
  }

  augeas { 'puppetnode1':
    context => '/files/etc/hosts',
    changes => [
      "set 01/ipaddr 192.168.31.221",
      "set 01/canonical puppetnode1.aisuhua.net",
      "set 01/alias[1] puppetnode1",
    ],
    onlyif => "match *[ipaddr = '192.168.31.221'] size == 0"
  }

  augeas { 'puppetnode2':
    context => '/files/etc/hosts',
    changes => [
      "set 01/ipaddr 192.168.31.222",
      "set 01/canonical puppetnode2.aisuhua.net",
      "set 01/alias[1] puppetnode2",
    ],
    onlyif => "match *[ipaddr = '192.168.31.222'] size == 0"
  }

  augeas { 'puppetnode3':
    context => '/files/etc/hosts',
    changes => [
      "set 01/ipaddr 192.168.31.186",
      "set 01/canonical puppetnode3.aisuhua.net",
      "set 01/alias[1] puppetnode3",
    ],
    onlyif => "match *[ipaddr = '192.168.31.186'] size == 0"
  }
}