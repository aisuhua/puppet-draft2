# 负载均衡的实现
# @see http://nginx.org/en/docs/http/load_balancing.html
# @see https://docs.nginx.com/nginx/admin-guide/load-balancer/http-load-balancer/
# @see https://help.aliyun.com/product/27537.html
# see https://devco.re/blog/2014/06/19/client-ip-detection/
#
class lb::config {

  file { '/etc/nginx/conf.d':
    ensure => directory,
    source => 'puppet:///modules/lb/conf.d',
    recurse => true,
    require => Package['nginx'],
    notify => Service['nginx']
  }

  # nginx.conf
  file { '/etc/nginx/nginx.conf':
    ensure => file,
    source => 'puppet:///modules/lb/nginx.conf',
    require => Package['nginx'],
    notify => Service['nginx']
  }
}