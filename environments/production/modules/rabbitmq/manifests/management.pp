class rabbitmq::management {

  # Must use the full command path or it will halt error.
  # Error: Only root or rabbitmq can run
  Exec { 'install-rabbitmq-management':
    command => "/usr/sbin/rabbitmq-plugins enable rabbitmq_management",
    require => Package['rabbitmq-server'],
    notify => Service['rabbitmq-server'],
    unless => "/usr/sbin/rabbitmq-plugins list | /bin/grep '\[E\*\] rabbitmq_management'"
  }
}