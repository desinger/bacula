FROM debian:jessie
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
RUN apt-get install -y apache2 libapache2-mod-php5
RUN apt-get install -y php5 php5-gd php5-mysql

RUN apt-get -y install curl
RUN cd /var/www/
RUN curl -O http://www.bacula-web.org/files/bacula-web.org/downloads/bacula-web-latest.tgz
RUN tar -xzf bacula-web-latest.tgz -C /var/www/html
RUN adduser --disabled-password --gecos "" apache
RUN chown -Rv apache:apache /var/www
RUN chown -Rv www-data: /var/www/
RUN chmod -Rv u=rx,g=rx,o=rx /var/www/
RUN chmod -Rv ug+w /var/www/html/application/view/cache
RUN rm /var/www/html/index.html

 
ADD config.php /var/www/html/application/config
RUN mkdir /var/www/html/configs
ADD bacula.conf /var/www/html/configs/
#nano /etc/apache2/apache2.conf 
#put this inside conf file
#
#RUN echo "<Directory /var/www/html/>  /
# AllowOverride All  /
#</Directory>" >> /etc/apache2/apache2.conf


