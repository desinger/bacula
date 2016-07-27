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
    echo mysql-server-5.5 mysql-server/root_password_again password 1 | debconf-set-selections


RUN apt-get update && \
    apt-get install  git make file mysql-client libmysqlclient-dev build-essential && \
    git clone http://git.bacula.org/bacula trunk
#    apt-get install build-essential #libgl1-mesa-dev mtx && \ 
#lib for ./configure on bacula source
#    echo mysql-server-5.5 mysql-server/root_password password 1 | debconf-set-selections && \
#    echo mysql-server-5.5 mysql-server/root_password_again password 1 | debconf-set-selections && \
#used only se we can install bacule with mysql support , need to remove at the end
RUN cd /trunk/bacula && \
    ./configure --enable-smartalloc --enable-batch-insert --with-mysql && \
    make && \
    make install

RUN rm -R /trunk && \
#    apt-get remove mysql-client libmysqlclient-dev && \ #can't create database  mysql is required
    apt-get install ssmtp nano && \
    mkdir -p /bacula/backup /bacula/restore && \
    adduser --disabled-password --gecos "" bacula && \
    chown -R bacula:bacula /bacula && \
    chmod -R 700 /bacula


#Add Bacula to path so running 'docker exec -ti ... bconsole' works
ENV PATH=$PATH:/etc/bacula
RUN mkdir /etc/bacula/plugins
ADD run.sh /tmp
RUN chmod +x /tmp/run.sh
EXPOSE 9101:9101
EXPOSE 9102:9102
EXPOSE 9103:9103
CMD ["/bin/bash", "-c",  "/tmp/run.sh"]

#docker build -t stanimirvelikov/bacula /home/stanimir/bacula
#docker run --name test -P --env="DB_TYPE=sqlite3" -it stanimirvelikov/bacula tail -f /dev/null #puska v interaktgiv da pisha
#docker run --name test -p 9101:9101 -p 9102:9102 -p 9103:9103 -d stanimirvelikov/bacula tail -f /dev/null #background
#docker exec -it test /bin/bash
