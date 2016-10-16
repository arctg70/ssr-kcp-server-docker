FROM alpine:edge
MAINTAINER Min Yu <yumin9822@gmail.com>

RUN apk update \
    && apk add python libsodium unzip wget \
    && rm -rf /var/cache/apk/*

RUN mkdir /ssr \
    && cd /ssr \
    && wget --no-check-certificate https://github.com/breakwa11/shadowsocks/archive/manyuser.zip -O /tmp/manyuser.zip \
    && unzip -d /tmp /tmp/manyuser.zip \
    && mv /tmp/shadowsocks-manyuser/shadowsocks /ssr/shadowsocks \
    && rm -rf /tmp/*

ENV server="0.0.0.0" server_ipv6="::" server_port=8080 password="CTYDDDDDDBUG" method="chacha20" protocol="auth_sha1_compatible" obfs="http_simple_compatible"
RUN echo "{"\"server\":\"$server\"","\"server_ipv6\":\"$server_ipv6\"","\"server_port\":\"$server_port\"","\"password\":\"$password\"","\"timeout\":120","\"udp_timeout\":60","\"method\":\"$method\"","\"protocol\":\"$protocol\"","\"obfs\":\"$obfs\"","\"dns_ipv6\":false","\"connect_verbose_info\":0","\"redirect\":\"\"","\"fast_open\":true"}" > /config.json
ADD dns.conf /ssr/shadowsocks/dns.conf
ADD r.sh /ssr/shadowsocks/r.sh
RUN chmod +x /ssr/shadowsocks/r.sh

WORKDIR /ssr/shadowsocks

CMD /ssr/shadowsocks/r.sh
