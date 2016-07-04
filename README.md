# docker-for-logstash
Dockerfile to install and run LogStash

Build: docker build -t logstash:v1 -f Dockerfile .

Run: docker run -d -p 80:5227/udp logstash:v1
