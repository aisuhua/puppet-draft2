<?php
/**
 * 获取用户IP
 *
 * @link https://devco.re/blog/2014/06/19/client-ip-detection/
 */
echo 'Client IP: ', get_client_ip(), PHP_EOL;

function get_client_ip()
{
    if (isset($_SERVER['HTTP_X_FORWARDED_FOR']) && !empty($_SERVER['HTTP_X_FORWARDED_FOR']))
    {
        $exploded = explode(',', $_SERVER['HTTP_X_FORWARDED_FOR']);
        foreach ($exploded as $ip)
        {
            $ip = trim($ip);
            if (filter_var($ip, FILTER_VALIDATE_IP))
            {
                return $ip;
            }
        }
    }

    if (isset($_SERVER['REMOTE_ADDR']) && !empty($_SERVER['REMOTE_ADDR']))
    {
        if (filter_var($_SERVER['REMOTE_ADDR'], FILTER_VALIDATE_IP))
        {
            return $_SERVER['REMOTE_ADDR'];
        }
    }

    return '0.0.0.0';
}