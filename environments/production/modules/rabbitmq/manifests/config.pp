class rabbitmq::config {

  # https://raw.githubusercontent.com/rabbitmq/rabbitmq-server/master/docs/rabbitmq.conf.example
  file { '/etc/rabbitmq/rabbitmq.conf':
    ensure => file,
    source => 'puppet:///modules/rabbitmq/rabbitmq.conf',
    require => Package['rabbitmq-server'],
    notify => Service['rabbitmq-server']
  }
}