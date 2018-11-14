class user::aisuhua {
  accounts::user { 'aisuhua':
    # 加入 sudo 组，可以使用 sudo 执行命令
    groups => ['aisuhua','sudo'],
    shell => '/bin/bash',
    # shell> openssl passwd -1 用户密码
    password => '$1$6Weoolps$Yrx/B8XND7xgmPtvp3sna.',
    locked => false,
    # 用户本地公钥，用于生成 authorized_keys，实现免密登录
    # 一般先在 puppetmater 创建 aisuhua 用户，然后将公钥贴在这里，以后使用 aisuhua 用户对其他服务器进行批量管理
    sshkeys => [
      #'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDSkdf5DQNFAeUJjkQcs/42/GdTedX6thyQcUIKvPAyOvQVXADtIxLTC6IV7yFC409SaEzLRdYtqQFILkSmc3y3Y4Njbzah1YlFLNUkTu0SwxGsZKrks4LseBcchTIiq/zb7OajKVilLrqwmv94Zr6KUhCsOT6NnbeL6RtKeBVrAkhS1tsWcgIkZ4MTC1zEW6r2eWMVU4ms2M1om81wTEbSvUmSvOkrMPPy9ypXdR6Y71BzEmYlcqolNkRpV1Eor5kixT9rEWKUvUHxRGcv/4dFycD67C2tjKMMY35qC6PkoRs1Fi9T2wez6D82KKbKxiiW3xKVWAmAxmSxUkTnsEAX aisuhua@puppetmaster.aisuhua.net'
      'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDilDTO1sOUiwsL5Xcl0kyjdqfRx1b7WrU68Wpp5A0+pEQK+PYZXkhfnD7+9DYdmRlB+Pu/vdBiHKYfCNPprsdUc2iqRBPvw5L3pKq0QW3hP9wTiLIaW7kfTjZQcpMZUkk3rXj2VGZ5864WGYMiOL7RzijvzaFw6nKyiXRkvX97tBTXC85HDnZLhFYsnT5KequaAKqMgO8sqv1bETtcPbY4CxedwErWw+J9XZZj3ckXtGHfpe4kXZqztHGcxmHr1actSB8dTLsFgTI7h7sS/qes/iw//EqaZRMpRljZ39zHqoq/p9AqGnw/CbTDRBccbp28ZYA2gFAJcElDQ81jzrdp aisuhua@puppetmaster.aisuhua.net'
    ]
  }
}