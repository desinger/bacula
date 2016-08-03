FROM mysql
RUN apt-get update && \
  apt-get install nano
ADD run.sh /tmp
RUN mkdir /home/mysql && \ 
chmod +x /tmp/run.sh
#CMD ["/bin/bash", "-c",  "/tmp/run.sh"]

