FROM teddysun/xray

RUN apk add --no-cache openssh-server

COPY config.json /etc/xray/config.json
COPY start.sh /start.sh

RUN chmod +x /start.sh

CMD ["/start.sh"]