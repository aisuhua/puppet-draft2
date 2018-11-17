# LB机器
# lb1.192.168.1.111.hn1.aisuhua.net
# lb2.192.168.1.112.hn1.aisuhua.net
#
node /^lb\d+\.\d+\.\d+\.\d+\.\d+\.hn1\.aisuhua\.net$/ {
  include roles
  include base
  # include nginx
  # include lb::config
  # include lb::foo
  # include lb::demo
  # include keepalived
  include haproxy
  include haproxy::wp_web
}