FROM ubuntu:latest

RUN apt-get update -y && apt-get install -y xz-utils make gcc pkg-config fontconfig libcairo* libgtk2.0-dev libglib2.0-dev automake autotools-dev wget emacs

RUN cd /tmp && wget http://www.abenteuerland.at/download/smrender/current/smrender-4.0.r1854.tar.xz &&  xzcat smrender-4.0.r1854.tar.xz | tar xvf - && cd smrender-4.0.r1854 && sed -i -e "1i #include<glib.h>"  src/smrender_dev.h

RUN (export LDFLAGS=-lglib-2.0;cd /tmp/smrender-4.0.r1854;./configure --;make;make install)

