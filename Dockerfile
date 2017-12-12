FROM php:latest-fpm-alpine

ADD setup.sh setup.sh
RUN chmod +rx setup.sh && sync && ./setup.sh

# php & xdebug port
EXPOSE 9000 9999
