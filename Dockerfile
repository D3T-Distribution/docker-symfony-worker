FROM ubuntu:xenial

RUN apt-get update -qq && apt-get install -y -qq curl supervisor git wget tzdata software-properties-common libxrender1
RUN LC_ALL=C.UTF-8 add-apt-repository -y ppa:ondrej/php
RUN echo "Europe/Paris" > /etc/timezone && dpkg-reconfigure -f noninteractive tzdata
# install php 7.1
RUN apt-get update -qq && apt-get install -y -qq php7.1-cli php7.1-common php7.1-mysql php7.1-xml php7.1-bcmath php7.1-mbstring php7.1-zip php-curl php-apcu php-ssh2 php7.1-soap php-imagick php7.1-gd php7.1-intl

# Install wkhtmltox with deps
RUN wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.3/wkhtmltox-0.12.3_linux-generic-amd64.tar.xz && \
 tar xf wkhtmltox-0.12.3_linux-generic-amd64.tar.xz && \
 rsync -av wkhtmltox/* / && \
 chmod u+x /bin/wkhtmltoimage /bin/wkhtmltopdf && \
 rm wkhtmltox-0.12.3_linux-generic-amd64.tar.xz

# Configure runner
RUN sed -e 's/;date\.timezone =/date\.timezone = Europe\/Paris/' -i /etc/php/7.1/cli/php.ini 

VOLUME /var/www
WORKDIR /var/www/current
