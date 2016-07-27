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

RUN echo deb http://bacula.org/downloads/baculum/debian jessie main >> /etc/apt/sources.list && \
echo deb-src http://bacula.org/downloads/baculum/debian jessie main >> /etc/apt/sources.list


RUN apt-get update && \
apt-get install wget 
RUN wget -qO - http://bacula.org/downloads/baculum/baculum.pub | apt-key add -
RUn apt-get install baculum baculum-apache2 

RUN ln -s /etc/apache2/mods-available/rewrite.load /etc/apache2/mods-enabled/rewrite.load
RUn ln -s /etc/apache2/sites-available/baculum.conf /etc/apache2/sites-enabled/baculum.conf

#RUN service apache2 restart
#Access from web browser: http://localhost:9095

#First time login: admin

#First time password: admin

 



