FROM httpd:2.4
MAINTAINER stanimirvelikov
ENV DEBIAN_FRONTEND noninteractive 
ENV APT_LISTCHANGES_FRONTEND noninteractive

RUN echo 'APT::NeverAutoRemove "0";' >> /etc/apt/apt.conf.d/01usersetting && \
    echo 'APT::Get::AllowUnauthenticated "1";' >> /etc/apt/apt.conf.d/01usersetting && \
    echo 'APT::Update::AllowUnauthenticated "1";' >> /etc/apt/apt.conf.d/01usersetting && \
    echo 'APT::Install-Suggests "0";' >> /etc/apt/apt.conf.d/01usersetting && \
    echo 'APT::Install-Recommends "0";' >> /etc/apt/apt.conf.d/01usersetting && \
    echo 'APT::Get::Assume-Yes "true";' >> /etc/apt/apt.conf.d/01usersetting && \
    echo 'APT::Get::force-yes "true";' >> /etc/apt/apt.conf.d/01usersetting


RUN apt-get update
#    apt-get install -y apache2 libapache2-mod-php5 && \
    apt-get install -y php5 php5-gd php5-mysql && \
    apt-get -y install curl && \
    cd /var/www/ && \
    curl -O http://www.bacula-web.org/files/bacula-web.org/downloads/bacula-web-latest.tgz && \
    tar -xzf bacula-web-latest.tgz -C /var/www/html && \
    adduser --disabled-password --gecos "" apache && \
    chown -Rv apache:apache /var/www && \
    chown -Rv www-data: /var/www/ && \
    chmod -Rv u=rx,g=rx,o=rx /var/www/ && \
    chmod -Rv ug+w /var/www/html/application/view/cache && \
    rm /var/www/html/index.html && \
    mkdir /var/www/html/configs
 
ADD config.php /var/www/html/application/config
ADD bacula.conf /var/www/html/configs/
#nano /etc/apache2/apache2.conf 
#put this inside conf file
#
#RUN echo "<Directory /var/www/html/>  /
# AllowOverride All  /
#</Directory>" >> /etc/apache2/apache2.conf


