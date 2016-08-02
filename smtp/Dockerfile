FROM debian:jessie
MAINTAINER Stanimir Velikov <s.velikof@gmail.com>

RUN echo 'APT::NeverAutoRemove "0";' >> /etc/apt/apt.conf.d/01usersetting  \
    echo 'APT::Get::AllowUnauthenticated "1";' >> /etc/apt/apt.conf.d/01usersetting  \
    echo 'APT::Update::AllowUnauthenticated "1";' >> /etc/apt/apt.conf.d/01usersetting  \
    echo 'APT::Install-Suggests "0";' >> /etc/apt/apt.conf.d/01usersetting  \
    echo 'APT::Install-Recommends "0";' >> /etc/apt/apt.conf.d/01usersetting  \
    echo 'APT::Get::Assume-Yes "true";' >> /etc/apt/apt.conf.d/01usersetting  \
    echo 'APT::Get::force-yes "true";' >> /etc/apt/apt.conf.d/01usersetting  \
apt-get update
apt-get install postfix apt-utils

sed -i -e "s/inet_interfaces = all/inet_interfaces = localhost/" /etc/postfix/main.cf

myorigin = Bacula
 
postfix postfix/main_mailer_type        select  Internet Site
 
 
 

 
 
 
 
 
 