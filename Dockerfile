FROM debian:jessie
MAINTAINER stanimirvelikov

#docker run -t -i ubuntu /bin/bash
#debconf-get-selections | grep mysql #### pokazva vypros na programa pri instalaciq
#docker run -d --name test -p 9101:9101 -p 9102:9102 -p 9103:9103 --env="DB_TYPE=sqlite3" stanimirvelikov/bacula

RUN apt-get update
RUN apt-get -y install apt-utils

RUN apt-get update
RUN apt-get -y install git
RUN git clone http://git.bacula.org/bacula trunk         
RUN cd /trunk/bacula
RUN apt-get update
RUN apt-get -y install build-essential libgl1-mesa-dev mtx #biblioteka za ./configure na bacula source

#RUN rm /var/lib/apt/lists/lock # neshto ne pozvolqva instalaciq  na mysql
#RUN rm /var/cache/apt/archives/lock # neshto ne pozvolqva instalaciq  na mysql

RUN apt-get update
RUN apt-get -y install sqlite3 libsqlite3-dev

RUN apt-get update && \
DEBIAN_FRONTEND=noninteractive apt-get install -y make file && \
cd trunk/bacula && \
./configure \
	--enable-smartalloc \
	--enable-batch-insert \
	--with-sqlite3 && \
make && make install


RUN apt-get install -y ssmtp
#RUN apt-get install -y postfix
#RUN echo postfix postfix postfix postfix/main_mailer_type select Internet Site | debconf-set-selections 
#RUN echo postfix postfix postfix postfix/mailname string s.velikov@bolero-bg.com | debconf-set-selections
#RUN service postfix stop
RUN apt-get install -y bsd-mailx 

#RUN chmod 755 /etc/bacula/scripts/delete_catalog_backup
RUN mkdir -p /bacula/backup /bacula/restore


RUN adduser --disabled-password --gecos "" bacula
#useradd -m -p <encryptedPassword> <user>
#    -m, --create-home: Create user home directory
#    -p, --password: Specify user password


RUN chown -R bacula:bacula /bacula
RUN chmod -R 700 /bacula
ADD bacula-dir.conf /etc/bacula/bacula-dir.conf
ADD bacula-fd.conf /etc/bacula/bacula-fd.conf
ADD bacula-sd.conf /etc/bacula/bacula-sd.conf
ADD bconsole.conf /etc/bacula/bconsole.conf

RUN cd /etc/bacula && \
./create_sqlite3_database && \
./make_bacula_tables && \
./grant_sqlite3_privileges


VOLUME /data
VOLUME /etc/bacula
VOLUME /var/spool/bacula
ENV PATH=$PATH:/etc/bacula

EXPOSE 9101
EXPOSE 9102
EXPOSE 9103
EXPOSE 25

#docker run --name test -p 9101:9101 -p 9102:9102 -p 9103:9103 --env="DB_TYPE=sqlite3" -it stanimirvelikov/bacula bash
