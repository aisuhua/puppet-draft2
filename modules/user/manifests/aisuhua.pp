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
      'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCnBoS+P/2Um290+ViQOosDvWeTVwy7QGexR3ovX1G2wezBO74LA3T59yQtEaiLEZYr2AvRabR3BCINqml17ms59/KyngsYkoqnE2/y3ygwXydJSPy8L3CuYe0VVS/ViHF8HUvs5pOh1TYZfELbH1FjFbCAQ5EES5F6VM02FeK0GPk0Y07IB/xwVvYZGKe/BsiKgXMJIX13R6x4TMSaoIBb4KPF69m2sVwPBjt+D5Xs7k7oduaTvdTvFx3Qh3uLHXHSsWNkW3omohdM9pRSpA6B2eNVlNEdCgtbm5RzIpyf7qSkhc3E0fnjmt/f9iIxpPzSWkSxxudICIhJSao3eu4D aisuhua@puppetmaster.aisuhua.net'
      #'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDilDTO1sOUiwsL5Xcl0kyjdqfRx1b7WrU68Wpp5A0+pEQK+PYZXkhfnD7+9DYdmRlB+Pu/vdBiHKYfCNPprsdUc2iqRBPvw5L3pKq0QW3hP9wTiLIaW7kfTjZQcpMZUkk3rXj2VGZ5864WGYMiOL7RzijvzaFw6nKyiXRkvX97tBTXC85HDnZLhFYsnT5KequaAKqMgO8sqv1bETtcPbY4CxedwErWw+J9XZZj3ckXtGHfpe4kXZqztHGcxmHr1actSB8dTLsFgTI7h7sS/qes/iw//EqaZRMpRljZ39zHqoq/p9AqGnw/CbTDRBccbp28ZYA2gFAJcElDQ81jzrdp aisuhua@puppetmaster.aisuhua.net'
    ]
  }
}