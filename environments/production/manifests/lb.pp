# LB机器
# lb1.192.168.1.111.hn1.aisuhua.net
#
node /^lb\d+\.\d+\.\d+\.\d+\.\d+\.hn1\.aisuhua\.net$/ {
  include roles
  include base
  include nginx
}