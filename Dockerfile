FROM ubuntu:xenial

RUN apt-get update  && \
    apt-get install -y bash make musl-dev gcc unzip python2.7 rsync

WORKDIR /

COPY simhv39.zip unix.zip /

RUN mkdir -p simhv39

RUN cd simhv39 && unzip ../simhv39.zip 

RUN unzip ../unix.zip

RUN cd / && make -C simhv39 BIN/pdp11

RUN cp /simhv39/BIN/pdp11 /unix/tools

RUN make -C unix

ADD start.sh /start.sh

ENTRYPOINT ["./start.sh"]
