FROM alpine:edge


RUN apk update \
    && apk add python libsodium unzip wget \
    && rm -rf /var/cache/apk/*

RUN mkdir /ssr \
    && cd /ssr \
    && wget --no-check-certificate https://github.com/breakwa11/shadowsocks/archive/manyuser.zip -O /tmp/manyuser.zip \
    && unzip -d /tmp /tmp/manyuser.zip \
    && mv /tmp/shadowsocks-manyuser/shadowsocks /ssr/shadowsocks \
    && rm -rf /tmp/*


COPY config.json /config.json
COPY dns.conf /ssr/shadowsocks/dns.conf
COPY r.sh /ssr/shadowsocks/r.sh
RUN chmod +x /ssr/shadowsocks/r.sh

WORKDIR /ssr/shadowsocks

CMD /ssr/shadowsocks/r.sh
