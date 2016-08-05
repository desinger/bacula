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
    echo 'APT::Get::force-yes "true";' >> /etc/apt/apt.conf.d/01usersetting && \
    echo mysql-server-5.5 mysql-server/root_password password 1 | debconf-set-selections && \
    echo mysql-server-5.5 mysql-server/root_password_again password 1 | debconf-set-selections && \
#
    apt-get update && \
    apt-get install  git make file mysql-client libmysqlclient-dev build-essential ssmtp nano && \
    git clone http://git.bacula.org/bacula trunk && \
    mkdir -p /bacula/backup /bacula/restore /etc/bacula/plugins && \
    adduser --disabled-password --gecos "" bacula && \
    chown -R bacula:bacula /bacula && \
    chmod -R 777 /bacula && \
    cd /trunk/bacula && \
    ./configure --enable-smartalloc --enable-batch-insert --with-mysql && \
    make && \
    make install && \
    rm -R /trunk && \
    apt-get clean && \
    apt-get purge git make file build-essential && \
    apt-get autoremove

#Add Bacula to path so running 'docker exec -ti ... bconsole' works
ENV PATH=$PATH:/etc/bacula
ADD run.sh /tmp  
ADD ./scripts/* /tmp/
#ADD ./scripts/director /tmp && \
## ./scripts/storage /tmp && \
# ./scripts/catalog /tmp && \
# ./scripts/monitor /tmp && \
# ./scripts/client1 /tmp && \
# ./scripts/client2 /tmp && \
# ./scripts/mail /tmp


RUN chmod o+x /tmp/run.sh  \
    && sed -i -e 's/\r$//' /tmp/run.sh

EXPOSE 9101:9101 9102:9102 9103:9103
VOLUME /etc/bacula/
VOLUME /bacula
CMD ["/bin/bash", "-c",  "/tmp/run.sh"]

