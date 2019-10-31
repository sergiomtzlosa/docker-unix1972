FROM ubuntu:xenial

WORKDIR /

RUN apt-get update && apt-get install -y unzip make gcc libncurses-dev

COPY simhv39.zip unix-bugfix-compile-on-new-systems.zip /

RUN mkdir -p simhv39

RUN cd simhv39 && unzip ../simhv39.zip 

RUN unzip ../unix-bugfix-compile-on-new-systems.zip

RUN cd / && make -C simhv39 BIN/pdp11

RUN cp /simhv39/BIN/pdp11 /unix-bugfix-compile-on-new-systems/tools

RUN make -C unix-bugfix-compile-on-new-systems

ADD start.sh /start.sh

#ENTRYPOINT ["./start.sh"]
