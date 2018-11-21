# Puppet Draft2

使用 [puppet](https://puppet.com/) 多主机部署站点的例子，支持生产、灰度和内网环境。

## 服务器规划

puppetmaster
 
- puppetmaster.aisuhua.net

load balance (nginx + keepalived 实现双主高可用)

- lb1.192.168.1.111.hn1.aisuhua.net
- lb2.192.168.1.112.hn1.aisuhua.net

生产环境

- wp-web1.192.168.1.100.hn1.aisuhua.net
- wp-web2.192.168.1.101.hn1.aisuhua.net 
- wp-worker1.192.168.1.150.hn1.aisuhua.net
- wp-worker2.192.168.1.151.hn1.aisuhua.net
- wp-rabbitmq1.192.168.1.250.hn1.aisuhua.net

灰度环境

- pre-release1.192.168.1.200.hn1.aisuhua.net
- pre-release2.192.168.1.201.hn1.aisuhua.net

内网环境

- web1.dev.aisuhua.net
- web2.dev.aisuhua.net
- worker1.dev.aisuhua.net
- worker2.dev.aisuhua.net

数据库

- wp-db1.192.168.1.40.hn1.aisuhua.net
- wp-db2.192.168.1.41.hn1.aisuhua.net

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

## Nginx 模块

nginx 模块加入了对灰度环境、获取 PHP-FPM 和 Nginx 运行状态以及跨域调用的配置示例。

### 灰度环境

请参考文件 foo.com.erb、prerelease.conf.erb 和 upstream.conf。

### 获取状态信息

请参考文件 status.conf 

### 跨域

假设有两个站点 foo.aisuhua.com 和 demo.aisuhua.com

- 当访问 http://demo.aisuhua.com/cors_client.html 可观察服务端如何使用 PHP 实现对跨域的支持；(需先注释掉 cors.conf )
- 当访问 http://demo.aisuhua.com/nginx_cors_client.html 可观察如何使用 Nginx 实现跨域支持；

跨域相关知识

- 当浏览器发现页面要做出跨域请求时，会自动携带 `Origin:` HTTP 报头，表明来自哪个域名的请求；
    - 例如：`Origin:http://demo.aisuhua.com`
- 服务端需返回 `Access-Control-Allow-Origin` 报头，表明支持该域名进行跨域请求；
    - `Access-Control-Allow-Origin: *` 表示支持所有域名发起的跨域请求；
    - `Access-Control-Allow-Origin: http://demo.aisuhua.com` 表示只当前 demo 域名的跨域请求；
- 当发起 Ajax 请求时设置了 `xhr.withCredentials = true`，那么在跨域调用时会带上 Cookie 信息；
    - 所带的 Cookie 信息必须是当前所请求域名具有访问权限的，例如 Cookie 的 domain 为 `.aisuhua.com`；
    - 同时服务端也必须返回 `Access-Control-Allow-Credentials: true`，表明接受该站点携带 Cookie 信息的请求；
    - 在此条件下，`Access-Control-Allow-Origin` 的值不能是通配符，必须是具体的域名，比如：`Access-Control-Allow-Origin：http://demo.aisuhua.com`；
- 当浏览器认为本次跨域请求并非「简单请求」时，会先进行预检请求，即使用 `OPTIONS` 动词进行请求；
    - 并非所有请求都需要进行预检，是否需要预检有时也取决于浏览器本身的实现；
    - 当服务器返回如 `Access-Control-Max-Age：86400` 时，可以要求浏览器对本次的 OPTIONS 请求结果进行缓存 1 天，也就不会每次都进行预检；
    
更多的实现细节和参考文献可以直接看实现的代码片段。

### 获取用户IP地址

无论是通过 LB 或者直接访问后端服务器，在后端都应能获取到用户的真实 IP 地址。
这里要借助 Nginx 的 `proxy` 相关指令来实现，其代码片段如下：

```nginx
proxy_set_header Host $http_host;
proxy_set_header X-Real-IP $remote_addr;
proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
proxy_set_header X-Forwarded-Proto $scheme;
```

发生 `proxy_pass` 的地方都应该传递这些报头，
具体参考 LB模块 的 nginx.conf 和 Nginx 模块的 pre_release.conf.erb 实现。
在服务端可以通过下面的方式获取，以 PHP 为例：

```php
if (isset($_SERVER['HTTP_X_FORWARDED_FOR']) && !empty($_SERVER['HTTP_X_FORWARDED_FOR'])) {
    $exploded = explode(',', $_SERVER['HTTP_X_FORWARDED_FOR']);
    foreach ($exploded as $ip) {
        $ip = trim($ip);
        if (filter_var($ip, FILTER_VALIDATE_IP)) {
            return $ip;
        }
    }
}

if (isset($_SERVER['REMOTE_ADDR']) && !empty($_SERVER['REMOTE_ADDR'])) {
    if (filter_var($_SERVER['REMOTE_ADDR'], FILTER_VALIDATE_IP)) {
        return $_SERVER['REMOTE_ADDR'];
    }
}
```
