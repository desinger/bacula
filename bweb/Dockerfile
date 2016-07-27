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
RUN apt-get install sudo nano
ADD settings.conf /usr/share/baculum/htdocs/protected/Data/

RUN echo Defaults:www-data	!requiretty >> /etc/sudoers
RUN echo www-data	ALL= NOPASSWD:	/usr/sbin/bconsole >> /etc/sudoers
RUN echo www-data	ALL= NOPASSWD:	/etc/bacula/bconsole >> /etc/sudoers
ADD libs/ /tmp/lib
ADD run.sh /tmp
RUN chmod +x /tmp/run.sh
VOLUME /etc/bacula/
VOLUME /bacula/
CMD ["/bin/bash", "-c",  "/tmp/run.sh"]


 



