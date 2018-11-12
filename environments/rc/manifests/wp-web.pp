# 内网 web 机器
# web1.dev.aisuhua.net
# web2.dev.aisuhua.net
#
node /^web\d+\.dev\.\d+\.\d+\.\d+\.\d+\.hn1\.aisuhua\.net$/ {
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
  include logrotate
  include logrotate::foo
}