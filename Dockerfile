FROM cntrump/ubuntu-template:20.04 AS base

FROM cntrump/ubuntu-toolchains:20.04 AS builder

RUN apt-get update && apt-get install flex bison libwrap0-dev -y

RUN git clone -b v1.4.2 --depth=1 https://github.com/cntrump/Dante.git \
    && cd ./Dante && autoreconf -i \
    && ./configure --prefix=/usr/local \
                   --with-socks-conf=/usr/local/dante/etc/socks.conf \
                   --with-sockd-conf=/usr/local/dante/etc/sockd.conf \
    && make && make install && cd .. && rm -rf ./Dante

FROM base

COPY --from=builder /lib/x86_64-linux-gnu/libgssapi.so.3 /lib/x86_64-linux-gnu/
COPY --from=builder /lib/x86_64-linux-gnu/libheimntlm.so.0 /lib/x86_64-linux-gnu/
COPY --from=builder /lib/x86_64-linux-gnu/libkrb5.so.26 /lib/x86_64-linux-gnu/
COPY --from=builder /lib/x86_64-linux-gnu/libasn1.so.8 /lib/x86_64-linux-gnu/
COPY --from=builder /lib/x86_64-linux-gnu/libhcrypto.so.4 /lib/x86_64-linux-gnu/
COPY --from=builder /lib/x86_64-linux-gnu/libroken.so.18 /lib/x86_64-linux-gnu/
COPY --from=builder /lib/x86_64-linux-gnu/libwind.so.0 /lib/x86_64-linux-gnu/
COPY --from=builder /lib/x86_64-linux-gnu/libheimbase.so.1 /lib/x86_64-linux-gnu/
COPY --from=builder /lib/x86_64-linux-gnu/libhx509.so.5 /lib/x86_64-linux-gnu/
COPY --from=builder /lib/x86_64-linux-gnu/libsqlite3.so.0 /lib/x86_64-linux-gnu/
COPY --from=builder /lib/x86_64-linux-gnu/libwrap.so.0 /lib/x86_64-linux-gnu/
COPY --from=builder /usr/local /usr/local

COPY sockd.conf /usr/local/dante/etc/

RUN ldd /usr/local/sbin/sockd

CMD ["sockd"]
