# RabbitMQ
# wp-rabbitmq1.192.168.1.250.hn1.aisuhua.net
#
node /^wp-rabbitmq\d+\.\d+\.\d+\.\d+\.\d+\.hn1\.aisuhua\.net$/ {
  include roles
  include base
  include rabbitmq
  include rabbitmq::management
}