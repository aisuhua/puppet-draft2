<?php
/**
 * 使用 CORS 协议允许跨域访问
 *
 * @see https://segmentfault.com/a/1190000011145364
 * @see https://gist.github.com/Stanback/7145487
 * @see https://stackoverflow.com/questions/27955233/nginx-config-for-cors-add-header-directive-is-not-allowed
 */

// 访问来源站点，如：http://demo.aisuhua.com
$http_origin = isset($_SERVER['HTTP_ORIGIN']) ? $_SERVER['HTTP_ORIGIN'] : '';
$cors = false;

// 允许跨域访问的域名
if (preg_match('/^https?:\/\/(.*?\.)?(aisuhua\.com|aisuhuarc\.com)$/', $http_origin)) {
    $cors = true;
}

// 允许跨越和携带证书（对于浏览器来将就是 Cookie）
if ($cors) {
    header("Access-Control-Allow-Origin: {$http_origin}");
    header("Access-Control-Allow-Credentials: true");
}

if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {
    header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");
    header("Access-Control-Allow-Headers: Origin, Content-Type, X-Requested-With");
    // 本次跨域请求的响应结果有效时间为一天，这避免了浏览器每次都发起 OPTIONS 请求
    header("Access-Control-Max-Age: 86400");
    return http_response_code(204);
}

echo 'suhua';