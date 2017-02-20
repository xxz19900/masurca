FROM ubuntu:trusty
MAINTAINER Daniel Vera

VOLUME /data

ENV URL ftp://ftp.genome.umd.edu/pub/MaSuRCA/latest/MaSuRCA-3.2.1_01202017.tar.gz
ENV CONFIG sr_config_example.txt

ENV PATH /data:/root/masurca/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

RUN apt-get update && \
 apt-get upgrade -y && \
 apt-get install -y wget gcc g++ make libboost-all-dev libzip2 libbz2-dev

WORKDIR /root

RUN wget -O- $URL | tar zx
RUN mv M* masurca
WORKDIR /root/masurca

RUN ./install.sh
RUN echo "cp /root/masurca/sr_config_example.txt /data/" > /usr/local/bin/example && chmod +x /usr/local/bin/example
RUN echo 'masurca $CONFIG' > /usr/local/bin/prepare && chmod +x /usr/local/bin/prepare

WORKDIR /data

CMD masurca
