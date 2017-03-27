# ssr-kcp-server-docker based on alpine
shadowsocksR python and kcptun docker on alpine

# usage
docker run --name ssr-kcp -d -p 29900:29900/udp -p 8989:8989 -p 8999:8999 arctg70/ssr-kcp-server-docker

# config.json
{

    "server": "0.0.0.0",
    "server_ipv6": "::",
    "local_address": "127.0.0.1",
    "local_port": 1080,
    "port_password":{
        "8989":{"protocol":"origin", "password":"131415", "obfs":"http_simple_compatible", "obfs_param":""},
        "8999":{"protocol":"auth_aes128_md5", "password":"131415"}
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

# KCPTUN 
/opt/kcptun/server_linux_amd64 -l :29900 -t 127.0.0.1:8989 -crypt "salsa20" --mtu 1350 --sndwnd 1024 --rcvwnd 1024 --mode "fast2"

