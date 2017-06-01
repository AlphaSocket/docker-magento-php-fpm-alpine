FROM php:5.6-fpm-alpine

ADD setup.sh setup.sh
RUN chmod +rx setup.sh && sync && ./setup.sh

# php & xdebug port
EXPOSE 9000 9999

ENTRYPOINT ["/usr/sbin/php-fpm", "--nodaemonize"]