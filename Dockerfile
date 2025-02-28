FROM alpine:latest
RUN apk update
RUN apk --no-cache add tor haproxy wget curl zlib-dev openssl-dev ruby &&\
    apk add polipo --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing/ &&\
    gem install excon

ADD start.rb /usr/local/bin/start.rb
RUN chmod +x /usr/local/bin/start.rb

ADD newnym.sh /usr/local/bin/newnym.sh
RUN chmod +x /usr/local/bin/newnym.sh

ADD haproxy.cfg.erb /usr/local/etc/haproxy.cfg.erb
ADD uncachable /etc/polipo/uncachable

EXPOSE 5566 4444

CMD ["/bin/sh", "-c", "/usr/local/bin/start.rb"]
