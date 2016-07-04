From ubuntu:14.04
MAINTAINER Eunkwang Joo <jooddang@gmail.com>

# Install basic packages
RUN \
	sudo apt-get update &&\
	sudo apt-get -qq -y install curl rcs git build-essential wget software-properties-common

# Install logstash
RUN wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
RUN echo "deb http://packages.elastic.co/logstash/2.1/debian stable main" | sudo tee -a /etc/apt/sources.list.d/elastic.list
RUN sudo apt-get update
RUN sudo apt-get install logstash

# Install Java
RUN sudo add-apt-repository ppa:webupd8team/java && \
	sudo apt-get update && \
	echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN sudo apt-get -y install oracle-java8-installer

# Copy config into container
COPY logstash.conf /etc/logstash/conf.d/logstash.conf
RUN touch /test.log
RUN chmod ugo+rwx /test.log

EXPOSE 5227 
CMD service logstash start agent -f /etc/logstash/conf.d/logstash.conf && tail -f /test.log
