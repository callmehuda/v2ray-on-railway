FROM callmehuda/xray

RUN apt install openssh-server -y

COPY config.json /etc/xray/config.json
COPY start.sh /start.sh

RUN chmod +x /start.sh

CMD ["/start.sh"]