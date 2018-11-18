# @summary Keepalived 保持 Nginx 高可用示例
# @link http://seanlook.com/2015/05/18/nginx-keepalived-ha/
# @link https://klionsec.github.io/2017/12/23/keepalived-nginx/
# @link https://linux.cn/article-5715-1.html
# @lihnk http://blog.51cto.com/zhangpenglinux/1782759
# @link http://www.ha97.com/899.html
# @link https://askubuntu.com/questions/547289/how-can-i-from-cli-assign-multiple-ip-addresses-to-one-interface

class keepalived::haproxy {

  package { 'keepalived':
    ensure => installed
  }

  file { '/etc/keepalived/keepalived.conf':
    ensure => present,
    source => "puppet:///modules/keepalived/haproxy/${fqdn}.conf",
    notify => Service['keepalived']
  }

  service { 'keepalived':
    enable => true,
    ensure => running,
    hasrestart => true,
    hasstatus=> true
  }
}