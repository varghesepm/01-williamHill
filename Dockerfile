FROM alpine:3.15.0

LABEL MAINTAINER="varghese p mathew"

RUN apk update && \
    apk upgrade && \
    apk --no-cache add nginx

RUN mkdir mkdir /var/tmp/nginx && \
    chown -R nginx /etc/nginx/ /var/lib/nginx/ /var/lib/nginx/logs /usr/lib/nginx/ /var/tmp/nginx /run/nginx /var/log/nginx/

USER nginx

CMD ["nginx", "-g", "daemon off;"]
