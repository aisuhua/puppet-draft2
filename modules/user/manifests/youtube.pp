class user::youtube {
  accounts::user { 'youtube':
    groups => ['youtube','sudo'],
    shell => '/bin/bash',
    password => '$1$6Weoolps$Yrx/B8XND7xgmPtvp3sna.', # shell> openssl passwd -1
    locked => false,
    sshkeys => [
      'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCtuKQ+2jQ1XQW/YZYHtaCcqZMuLTxiGGJRNizbj6HH99SswQFLYM/L1HKsr1DE06Dq6xEorY7dsuAfoMNmutZ02olMkR/9GiYZS2llsgyHd74c74yEf2Umj/Ibzm9yS5RYGHWpkRznG9QqVI66QU8R4TXvOzOBIHfEq+OBCPsFjxOerOhktHOJkJNrydvPGYDVlHIniNk2c7nTRZxjVcVtKRaVv6vEhGkHNQmpfTrs6ynvz4cMphmL7uArwWBql/B7mnkkM4K3jkUv1ytBSCY07v7irwLcrP0PLsdxZQkUDolnuOCI1FFP4Egyh1m+H1iKdQM6T7XuEOfsWohfwFpL suhua'
    ]
  }
}