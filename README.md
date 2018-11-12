# Puppet Draft2

使用 [puppet](https://puppet.com/) 多主机部署站点的例子，支持生产、灰度和内网环境。

## 服务器规划

生产环境

- wp-web1.192.168.1.100.hn1.aisuhua.net
- wp-web2.192.168.1.101.hn1.aisuhua.net 
- wp-worker1.192.168.1.150.hn1.aisuhua.net
- wp-worker2.192.168.1.151.hn1.aisuhua.net
- wp-rabbitmq1.192.168.1.250.hn1.aisuhua.net

灰度环境

- pre-release1.192.168.1.200.hn1.aisuhua.net
- pre-release-worker1.192.168.1.201.hn1.aisuhua.net

内网环境

- web1.dev.aisuhua.net
- web2.dev.aisuhua.net
- worker1.dev.aisuhua.net
- worker2.dev.aisuhua.net

## 改进

配置文件使用 yaml 实现，分成 3 个级别：服务器主机配置、分组配置、公共配置。
puppet 默认只支持主机和公共配置，该例子添加了对服务器分组配置的支持。

实现方式可参考 roles 模块，其原理是先对主机进行分组，然后给属于同一分组的主机添加一个相同的 factor `customrole`，
具有相同 `customrole` 的主机使用同一分组的配置。
主机分组信息写在 common.yaml，而分组配置所在目录写在 hirea.yaml。

common.yaml 内容片段：

```yaml
roles:
  wp-web:
    - 'wp-web1'
    - 'wp-web2'
  wp-worker:
    - 'wp-worker1'
    - 'wp-worker2'
  pre-release:
    - 'pre-release1'
    - 'pre-release-worker1'
```

hirea.yaml 内容片段：

```yaml
hierarchy:
  - name: "Node group data (yaml version)" 
    path: "roles/%{::customrole}.yaml" # 分组配置所在目录
```

- [best ways to define "workgroups/roles" with puppet](https://www.reddit.com/r/Puppet/comments/4m1ny6/best_ways_to_define_workgroupsroles_with_puppet/)

### 使用方法

首次请求 puppetmaster 时应先仅加载 `roles` 模块，让其先根据分组配置生成对应的 `customrole` factor，此后的请求再加载其他模块。
因为主机必须要先有 `customrole` 才知道属于哪个分组，才会使用分组的配置，否则首次请求时分组配置会无效。

## 基本操作

应用生产环境

```sh
shell> puppet agent --test --environment production --server puppetmaster.aisuhua.net
```

应用内网环境

```sh
shell> agent --test --environment rc --server puppetmaster.aisuhua.net
```

puppetmaster 端也可以利用 pssh 等工具批量登录远程主机并执行拉取操作

```sh
shell> pssh -h hosts -i "sudo puppet agent --test --environment production --server puppetmaster.aisuhua.net"
```

hosts 文件内容如下：

```sh
shell> cat hosts
192.168.1.143:25680
192.168.1.108:25680
192.168.1.168:25680
192.168.1.129:25680
```
