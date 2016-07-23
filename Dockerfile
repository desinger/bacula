FROM debian:jessie
MAINTAINER stanimirvelikov
#docker run -t -i ubuntu /bin/bash
#debconf-get-selections | grep mysql #### pokazva vypros na programa pri instalaciq
#ENV BACULA_VERSION "7.4.1"
#ENV BACULA_COMPONENTS "bacula-libs bacula-common bacula-libs-sql bacula-client bacula-director bacula-console"
RUN apt-get update
RUN apt-get -y install apt-utils

RUN apt-get update
RUN apt-get -y install git
RUN git clone http://git.bacula.org/bacula trunk         
RUN cd /trunk/bacula
RUN apt-get update
RUN apt-get -y install build-essential libgl1-mesa-dev mtx #biblioteka za ./configure na bacula source

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
RUN echo "Europe/Sofia" > /etc/timezone
RUN dpkg-reconfigure -f noninteractive tzdata
RUN mkdir -p /bacula/backup /bacula/restore

RUN adduser --disabled-password --gecos "" bacula

RUN chown -R bacula:bacula /bacula
RUN chmod -R 700 /bacula
ADD bacula-dir.conf /etc/bacula/bacula-dir.conf
ADD bacula-fd.conf /etc/bacula/bacula-fd.conf
ADD bacula-sd.conf /etc/bacula/bacula-sd.conf
ADD bconsole.conf /etc/bacula/bconsole.conf


VOLUME /data
VOLUME /etc/bacula
VOLUME /var/spool/bacula

#Add Bacula to path so running 'docker exec -ti ... bconsole' works
ENV PATH=$PATH:/etc/bacula

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