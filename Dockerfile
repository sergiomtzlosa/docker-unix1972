FROM ubuntu:xenial

RUN apt-get update && \
    apt-get install -y bash make musl-dev gcc unzip python python-dev rsync git 

WORKDIR /

COPY simhv39.zip /

RUN mkdir -p /simhv39 && cd /simhv39 && unzip ../simhv39.zip && cd / 

RUN make -C simhv39 BIN/pdp11

#RUN git clone https://github.com/sergiomtzlosa/unix.git && cd unix && git fetch && git checkout bugfix/compile-on-new-systems

COPY unix.zip /

RUN unzip unix.zip

RUN cp /simhv39/BIN/pdp11 /unix/tools

RUN ln -sf /usr/bin/python /usr/bin/python2

RUN make -C unix

ADD start.sh /start.sh

ENTRYPOINT ["./start.sh"]
