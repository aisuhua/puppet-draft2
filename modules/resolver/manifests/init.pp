# @summary 修改 DNS 服务器地址
# @see https://puppet.com/docs/puppet/5.5/quick_start_dns.html
#
class resolver {

  file { '/etc/resolv.conf':
    ensure => file,
    owner => 'root',
    group => 'root',
    mode => '0644',
    content => template('resolver/resolv.conf.erb'),
  }
}