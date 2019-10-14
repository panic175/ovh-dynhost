FROM alpine:3.10

RUN apk add --update --no-cache curl bind-tools

WORKDIR /usr/src/app

COPY dynhost.sh init.sh ./
RUN chmod +x ./dynhost.sh \
    && chmod +x ./init.sh

ENV STDOUT=/usr/src/app/dynhost.log \
    STDERR=/usr/src/app/dynhost.err

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout $STDOUT \
	&& ln -sf /dev/stderr $STDERR

RUN ln -sf /usr/src/app/dynhost.sh /etc/periodic/15min/dynhost

ENTRYPOINT ["/usr/src/app/init.sh"]

CMD [ "crond", "-f" ]
