class user::dba {
  accounts::user { 'dba':
    groups => ['dba','sudo'],
    shell => '/bin/bash',
    password => '$1$6Weoolps$Yrx/B8XND7xgmPtvp3sna.', # shell> openssl passwd -1
    locked => false,
    sshkeys => [
      'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCrrWoY9DgQ37w7BadsRkZAJNqAxdYmPx99XvJ+PUbtT9FldFsXFRg10OtXVTaniwkIA5YOP52j4AIpfbFw6F1TGJ8npScKNWYwpvfiXN5CqYfHmQb4Av7HESkgzOcBQUgTgesovScpsL2JluYoW83kHZABzq/hAEN9TZuVPeYtYLB17EpWVFBl2si7iplA/iP0/TFRhWxOYw68/A1U0mhAK4gAxosq/Sb6Mawfp1jaA2EwJcoBeKM8vZgXRkWFmKIFiKLvmpCZjoiqxhG+6pI3yDt0l/g7VN69RjCANYregBg1t9wpDhKjg1sPmJhLbnzAp08zlXMP3Fo4o58JCNoB archlinux-dg-home'
    ]
  }
}