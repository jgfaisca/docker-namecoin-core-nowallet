# version 1.1

FROM ubuntu:latest
MAINTAINER Jose G. Faisca <jose.faisca@gmail.com>

ARG DEBIAN_FRONTEND=noninteractive

# -- Namecoin variables ---
ENV IMAGE demo/namecoin-core-no-wallet
ENV RPC_USER rpc
ENV RPC_PASS secret
ENV RPC_ALLOW_IP 127.0.0.1
ENV MAX_CONNECTIONS 15
ENV RPC_PORT 8336
ENV PORT 8334
ENV NETWORK "" # mainnet

# -- Terminal ---
ENV TERM xterm

# -- Install main independencies --
RUN apt-get update \
        && apt-get install -y curl iproute2 git \
	libboost-all-dev dh-autoreconf \
	libcurl4-openssl-dev apg libboost-all-dev \
	build-essential libtool libevent-dev \
	bsdmainutils autoconf apg libqrencode-dev \
	libcurl4-openssl-dev automake make libssl-dev \
	libminiupnpc-dev pkg-config libzmq3-dev \
	autotools-dev python3

# -- Build Namecoin --
RUN git clone https://github.com/namecoin/namecoin-core.git \
        && cd namecoin-core \
        && ./autogen.sh \
        && ./configure --disable-wallet \
        CXXFLAGS="--param ggc-min-expand=1 --param ggc-min-heapsize=32768" \
        --enable-cxx \
        --disable-shared \
        --with-pic \
        --without-gui \
        --disable-upnp-default \
        && make \
        && make install

# -- Clean --
RUN cd / \
        && rm -rf /namecoin-core \
        && apt-get autoremove -y \
        && apt-get clean \
        && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY run.sh /usr/local/bin/
ENTRYPOINT ["run.sh"]

EXPOSE $RPC_PORT/tcp $PORT/tcp
VOLUME ["/data/namecoin"]
CMD ["namecoind", "-datadir=/data/namecoin", "-printtoconsole"]
