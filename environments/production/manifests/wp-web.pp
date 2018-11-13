# wp web 机器
# wp-web1.192.168.1.100.hn1.aisuhua.net
# wp-web2.192.168.1.101.hn1.aisuhua.net
#
node /^wp-web\d+\.\d+\.\d+\.\d+\.\d+\.hn1\.aisuhua\.net$/ {
  include roles
  include base
  include rsync
  include php72
  include php72::yar
  include php72::phalcon
  include php72::gearman
  include php72::couchbase
  include php72::xdebug
  include nginx
  include nginx::foo
  include nginx::demo
  include logrotate
  include logrotate::foo
}