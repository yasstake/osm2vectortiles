FROM ubuntu:latest

RUN apt-get update -y && apt-get install -y xz-utils make gcc pkg-config fontconfig libcairo* libgtk2.0-dev lib2.0-dev automake autotools-dev wget emacs make unzip git cmake

RUN cd /tmp && wget http://www.abenteuerland.at/download/smrender/current/smrender-4.0.r1854.tar.xz &&  xzcat smrender-4.0.r1854.tar.xz | tar xvf - && cd smrender-4.0.r1854 && sed -i -e "1i #include<glib.h>"  src/smrender_dev.h

RUN (export LDFLAGS=-lglib-2.0;cd /tmp/smrender-4.0.r1854;./configure --;make;make install)

ADD rules/rules.osm /

#RUN cd /tmp && git clone https://github.com/joto/osmcoastline && cd osmcoastline && mkdir build && cd build && cmake .. && make install

ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
    apt-get install -y software-properties-common && \
    add-apt-repository -y ppa:webupd8team/java && \
    apt-get update && \
    apt-get install -y oracle-java8-installer

#RUN cd /tmp &&  git clone https://github.com/yasstake/seafilter && cd seafilter && make && make install  

RUN wget -O - http://m.m.i24.cc/osmconvert.c | cc -x c - -lz -O3 -o /bin/osmconvert

RUN cd /tmp && wget http://bretth.dev.openstreetmap.org/osmosis-build/osmosis-latest.zip && cd /usr/local/ && unzip /tmp/osmosis-latest.zip
ADD Makefile /
ADD run.sh /

CMD /run.sh






