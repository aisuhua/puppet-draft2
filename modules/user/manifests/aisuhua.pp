class user::aisuhua {
  accounts::user { 'aisuhua':
    # 加入 sudo 组，可以使用 sudo 执行命令
    groups => ['aisuhua','sudo'],
    shell => '/bin/bash',
    # shell> openssl passwd -1 用户密码
    password => '$1$6Weoolps$Yrx/B8XND7xgmPtvp3sna.',
    locked => false,
    # 用户本地公钥，用于生成 authorized_keys，实现免密登录
    sshkeys => [
      'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCtuKQ+2jQ1XQW/YZYHtaCcqZMuLTxiGGJRNizbj6HH99SswQFLYM/L1HKsr1DE06Dq6xEorY7dsuAfoMNmutZ02olMkR/9GiYZS2llsgyHd74c74yEf2Umj/Ibzm9yS5RYGHWpkRznG9QqVI66QU8R4TXvOzOBIHfEq+OBCPsFjxOerOhktHOJkJNrydvPGYDVlHIniNk2c7nTRZxjVcVtKRaVv6vEhGkHNQmpfTrs6ynvz4cMphmL7uArwWBql/B7mnkkM4K3jkUv1ytBSCY07v7irwLcrP0PLsdxZQkUDolnuOCI1FFP4Egyh1m+H1iKdQM6T7XuEOfsWohfwFpL suhua'
    ]
  }
}