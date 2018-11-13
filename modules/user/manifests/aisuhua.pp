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
      #'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCnBoS+P/2Um290+ViQOosDvWeTVwy7QGexR3ovX1G2wezBO74LA3T59yQtEaiLEZYr2AvRabR3BCINqml17ms59/KyngsYkoqnE2/y3ygwXydJSPy8L3CuYe0VVS/ViHF8HUvs5pOh1TYZfELbH1FjFbCAQ5EES5F6VM02FeK0GPk0Y07IB/xwVvYZGKe/BsiKgXMJIX13R6x4TMSaoIBb4KPF69m2sVwPBjt+D5Xs7k7oduaTvdTvFx3Qh3uLHXHSsWNkW3omohdM9pRSpA6B2eNVlNEdCgtbm5RzIpyf7qSkhc3E0fnjmt/f9iIxpPzSWkSxxudICIhJSao3eu4D aisuhua@puppetmaster.aisuhua.net',
      'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDSkdf5DQNFAeUJjkQcs/42/GdTedX6thyQcUIKvPAyOvQVXADtIxLTC6IV7yFC409SaEzLRdYtqQFILkSmc3y3Y4Njbzah1YlFLNUkTu0SwxGsZKrks4LseBcchTIiq/zb7OajKVilLrqwmv94Zr6KUhCsOT6NnbeL6RtKeBVrAkhS1tsWcgIkZ4MTC1zEW6r2eWMVU4ms2M1om81wTEbSvUmSvOkrMPPy9ypXdR6Y71BzEmYlcqolNkRpV1Eor5kixT9rEWKUvUHxRGcv/4dFycD67C2tjKMMY35qC6PkoRs1Fi9T2wez6D82KKbKxiiW3xKVWAmAxmSxUkTnsEAX aisuhua@puppetmaster.aisuhua.net'
    ]
  }
}