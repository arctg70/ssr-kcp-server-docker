# ssr-kcp-server-docker based on alpine
shadowsocksR python and kcptun docker on alpine

# config.json
{
    "server": "0.0.0.0",
    "server_ipv6": "::",
    "local_address": "127.0.0.1",
    "local_port": 1080,
    "port_password":{
      "8989":"131415",
      "8127":"131415"
    },
    "timeout": 120,
    "udp_timeout": 60,
    "method":"chacha20",
    "protocol": "auth_aes128_md5",
    "protocol_param": "",
    "obfs": "http_simple",
    "obfs_param": "",
    "dns_ipv6": false,
    "connect_verbose_info": 0,
    "redirect": "",
    "fast_open": true
}

