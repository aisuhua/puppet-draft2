class resolver::company {

  # https://puppet.com/docs/puppet/5.5/quick_start_dns.html
  $nameservers = ['192.168.1.46', '223.5.5.5', '223.6.6.6']

  file { '/etc/resolv.conf':
    ensure => file,
    owner => 'root',
    group => 'root',
    mode => '0644',
    content => template('resolver/resolv.conf.erb'),
  }
}