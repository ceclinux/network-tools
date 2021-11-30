ARG UBUNTU_TAG=20.04
FROM ubuntu:${UBUNTU_TAG}

LABEL maintainer="ceclinux <https://github.com/ceclinux>" \
    description="A Docker image with various network tools pre-installed."

ENV TZ='US/Pacific-New' MCJOIN_VERSION='2.9'

RUN echo $TZ > /etc/timezone && \
    apt-get update && apt-get install -y tzdata && \
    rm /etc/localtime && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata

RUN apt-get install -y \
    apache2-utils \
    bash \
    byobu \
    htop \
    iputils-ping \
    bash-completion \
    ca-certificates \
    coreutils \
    curl \
    findutils \
    fping \
    git \
    ipcalc \
    iperf \
    iperf3 \
    iproute2 \
    gcc \
    jq \
    mtr \
    net-tools \
    vim \
    netcat-openbsd \
    ngrep \
    nload \
    nmap \
    openssh-client \
    smcroute \
    openssl \
    procps \
    make \
    socat \
    tcpdump \
    wget \
    python3 \
    autoconf \
    man-db \
    && apt-get clean && apt-get autoclean \
    && echo 'export PS1="[docker@network-tools]\$ "' >> /root/.bash_profile

RUN yes | unminimize

RUN \
wget https://github.com/troglobit/mcjoin/releases/download/v${MCJOIN_VERSION}/mcjoin-${MCJOIN_VERSION}.tar.gz && \
tar xvf mcjoin-${MCJOIN_VERSION}.tar.gz && \
cd mcjoin-${MCJOIN_VERSION} && \
./configure --prefix=/usr && \
make -j5 && \
make install-strip

CMD ["byobu"]
