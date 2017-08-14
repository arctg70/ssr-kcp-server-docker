#!/bin/sh

export KCPTUN_SS_CONF="/kcptun_ss_config.json"
export SS_CONF="/config.json"
# ======= SS CONFIG ======
export SS_SERVER_ADDR=${SS_SERVER_ADDR:-0.0.0.0}                     #"server": "0.0.0.0",
export SS_SERVER_PORT1=${SS_SERVER_PORT1:-8989}                     #"server_port": 8388,
export SS_SERVER_PORT2=${SS_SERVER_PORT2:-8999} 
export SS_PASSWORD1=${SS_PASSWORD1:-131415}                          #"password":"password",
export SS_PASSWORD2=${SS_PASSWORD2:-131415}                          #"password":"password",

export SS_PROTOCOL=${SS_PROTOCOL:-auth_aes128_md5}                          #"password":"password",
export SS_PROTOCOL1=${SS_PROTOCOL1:-origin}                          #"password":"password",
export SS_PROTOCOL2=${SS_PROTOCOL2:-auth_aes128_md5}                          #"password":"password",

export SS_OBFS=${SS_OBFS:-http_simple}                          #"password":"password",
#export SS_PASSWORD=${SS_PASSWORD:-131415}                          #"password":"password",
export SS_METHOD=${SS_METHOD:-chacha20}                           #"method":"aes-256-gcm",
export SS_TIMEOUT=${SS_TIMEOUT:-120}                                 #"timeout":600,
export SS_DNS_ADDR=${SS_DNS_ADDR:-8.8.8.8}                           #-d "8.8.8.8",
#export SS_UDP=${SS_UDP:-faulse}                                        #-u support,
export SS_FAST_OPEN=${SS_FAST_OPEN:-true}                            #--fast-open support,

# ======= KCPTUN CONFIG ======
export KCPTUN_SS_LISTEN=${KCPTUN_SS_LISTEN:-29900}                   #"listen": ":29900"
export KCPTUN_KEY=${KCPTUN_KEY:-password}                            #"key": "password",
export KCPTUN_CRYPT=${KCPTUN_CRYPT:-aes}                             #"crypt": "aes",
export KCPTUN_MODE=${KCPTUN_MODE:-fast2}                             #"mode": "fast2",
export KCPTUN_MTU=${KCPTUN_MTU:-1350}                                #"mtu": 1350,
export KCPTUN_SNDWND=${KCPTUN_SNDWND:-512}                           #"sndwnd": 512,
export KCPTUN_RCVWND=${KCPTUN_RCVWND:-512}                           #"rcvwnd": 512,

[ ! -f ${SS_CONF} ] && cat > ${SS_CONF}<<-EOF
{
    "server": "${SS_SERVER_ADDR}",
    "server_ipv6": "::",
    "local_address": "127.0.0.1",
    "local_port": 1080,
    "port_password":{
        "${SS_SERVER_PORT1}":{"protocol":"${SS_PROTOCOL1}", "password":"${SS_PASSWORD1}", "obfs":"http_simple_compatible", "obfs_param":""},
        "${SS_SERVER_PORT2}":{"protocol":"${SS_PROTOCOL2}", "password":"${SS_PASSWORD2}"}
    },
    "timeout":${SS_TIMEOUT} ,
    "udp_timeout": 60,
    "method":"${SS_METHOD}",
    "protocol": "${SS_PROTOCOL}",
    "protocol_param": "",
    "obfs": "${SS_OBFS}",
    "obfs_param": "",
    "dns_ipv6": false,
    "connect_verbose_info": 0,
    "redirect": "",
    "fast_open": ${SS_FAST_OPEN}
}
EOF

[ ! -f ${KCPTUN_SS_CONF} ] && cat > ${KCPTUN_SS_CONF}<<-EOF
{
    "listen": ":${KCPTUN_SS_LISTEN}",
    "target": "127.0.0.1:${SS_SERVER_PORT1}",
    "key": "${KCPTUN_KEY}",
    "crypt": "${KCPTUN_CRYPT}",
    "mode": "${KCPTUN_MODE}",
    "mtu": ${KCPTUN_MTU},
    "sndwnd": ${KCPTUN_SNDWND},
    "rcvwnd": ${KCPTUN_RCVWND},
    "nocomp": false
}
EOF

/usr/bin/supervisord -c /etc/supervisord.conf
