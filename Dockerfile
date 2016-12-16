FROM ubuntu:xenial

RUN echo "Europe/Paris" > /etc/timezone && dpkg-reconfigure -f noninteractive tzdata
RUN apt-get update -qq && apt-get install -y -qq curl supervisor git wget
RUN apt-get update -qq && apt-get install -y -qq php7.0-cli php7.0-common php7.0-mysql php7.0-xml php7.0-bcmath php7.0-mbstring php7.0-zip php-xdebug php-curl php-apcu php-ssh2 php7.0-soap php-imagick php7.0-gd
RUN apt-get update -qq && apt-get install -y -qq wkhtmltopdf xvfb

# Configure runner
RUN sed -e 's/;date\.timezone =/date\.timezone = Europe\/Paris/' -i /etc/php/7.0/cli/php.ini 

ADD supervisor/supervisord.conf /etc/supervisor/supervisord.conf

VOLUME /var/www
WORKDIR /var/www

CMD ["/usr/bin/supervisord"]
