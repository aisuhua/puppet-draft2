# LB机器
# wp-db1.192.168.1.40.hn1.aisuhua.net
# wp-db2.192.168.1.41.hn1.aisuhua.net
#
node /^wp-db\d+\.\d+\.\d+\.\d+\.\d+\.hn1\.aisuhua\.net$/ {
  include roles
  include base

  # https://forge.puppet.com/puppetlabs/mysql
  class { '::mysql::server':
    root_password => 'suhua123',
    override_options => {
      'mysqld' => {
        'bind-address' => '0.0.0.0',
        'character-set-server' => 'utf8mb4',
        'collation-server' => 'utf8mb4_unicode_ci'
      },
      'mysql' => {
        'default-character-set' => 'utf8mb4'
      }
    },
    restart => true
  }

  # To create a database with a user and some assigned privileges:
  mysql::db { 'test':
    user => 'aisuhua',
    password => '123456',
    dbname => 'test',
    host => '192.168.%',
    grant => [
      'SELECT',
      'UPDATE',
      'INSERT',
      'DELETE'
    ],
  }
}