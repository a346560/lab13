FROM ubuntu:16.04

RUN apt update
RUN apt install -yy gcc g++ cmake 

COPY . print/
WORKDIR print

RUN cmake -H. -B_build -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=_install
RUN cmake --build _build
RUN cmake --build _build --target install

ENV LOG_PATH /home/vershinin/lab13/logs/log.txt

VOLUME /home/vershinin/lab13/logs

WORKDIR _install/bin

CMD ./DEMO

