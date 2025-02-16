#
#	Base image
#	@see https://hub.docker.com/_/ubuntu
#
FROM ubuntu:plucky-20241213

#
#	Arguments
#
ARG BUILD_DATE
ARG S6_OVERLAY_VERSION='3.2.0.2'
ARG SPYSERVER_AMD64_ID='4262'
ARG SPYSERVER_ARM64_ID='5795'
ARG SPYSERVER_ARMHF_ID='4247'
ARG TARGETPLATFORM
ARG VCS_REF
ARG VCS_SRC
ARG VERSION

#
#	Environment variables
#
ENV APP_VERSION=${VERSION} \ 
  CONFIG_FILE="/config/spyserver.config" \
  DOCKER_CONTAINER=true \
  HOME="/root" \
  PS1="\[\e]0;\u@\h: \w\a\]\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ " \
  TERM="xterm" \
  VISUAL="nano"

#
#	Labels
#	@see https://github.com/opencontainers/image-spec/blob/master/annotations.md
#	@see https://semver.org/
#
LABEL maintainer="martin.dagarin@gmail.com" \
      org.opencontainers.image.authors="Martin Dagarin" \
      org.opencontainers.image.created=${BUILD_DATE} \
      org.opencontainers.image.description="AirSpy SpyServer" \
      org.opencontainers.image.documentation="https://github.com/SloCompTech/docker-spyserver" \
      org.opencontainers.image.revision=${VCS_REF} \
      org.opencontainers.image.source=${VCS_SRC} \
      org.opencontainers.image.title="AirSpy SpyServer" \
      org.opencontainers.image.url="https://github.com/SloCompTech/docker-spyserver" \
      org.opencontainers.image.version=${VERSION}

# Install packages
RUN apt update && \
    apt upgrade -y && \
    DEBIAN_FRONTEND=noninteractive apt install -y \
      bash \
      ca-certificates \
      cmake \
      coreutils \
      curl \
      git \
      iputils-ping \
      libusb-1.0-0-dev \
      nano \
      pkg-config \
      sudo \
      tar \
      tzdata \
      udev \
      unzip \
      xz-utils && \
    cd /tmp && \
    git clone https://github.com/rtlsdrblog/rtl-sdr-blog && \
    cd rtl-sdr-blog && \
    mkdir build && \
    cd build && \
    cmake ../ -DINSTALL_UDEV_RULES=ON && \
    make && \
    make install && \
    cp ../rtl-sdr.rules /etc/udev/rules.d/ && \
    ldconfig && \
    mkdir -p /etc/modprobe.d && \
    echo "# Blacklist default Linux DVB-T drivers" > /etc/modprobe.d/blacklist-rtl.conf && \
    echo "blacklist dvb_usb_rtl28xxu" >> /etc/modprobe.d/blacklist-rtl.conf && \
    rm -r /tmp/rtl-sdr-blog && \
    apt remove --autoremove -y \
      cmake && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

#
#	s6-overlay setup
# @see https://github.com/just-containers/s6-overlay
#
RUN case ${TARGETPLATFORM} in \
    "linux/amd64") S6_OVERLAY_ARCH='x86_64'  ;; \
    "linux/arm64")  S6_OVERLAY_ARCH='aarch64'  ;; \
    "linux/arm/v7")  S6_OVERLAY_ARCH='armhf'  ;; \
    *) exit 1 ;;\
    esac && \
    curl -o /tmp/s6-overlay-noarch.tar.xz -L "https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-noarch.tar.xz" && \
    tar -C / -Jxpf /tmp/s6-overlay-noarch.tar.xz && \
    curl -o /tmp/s6-overlay-arch.tar.xz -L "https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-${S6_OVERLAY_ARCH}.tar.xz" && \
    tar -C / -Jxpf /tmp/s6-overlay-arch.tar.xz && \
    rm /tmp/s6-overlay-*.tar.xz && \
    mkdir -p /app /config

#
# Install SpyServer
# @see https://airspy.com/download/
#
RUN case ${TARGETPLATFORM} in \
    "linux/amd64")  FILE_URL="https://airspy.com/?ddownload=${SPYSERVER_AMD64_ID}"  ;; \
    "linux/arm64")  FILE_URL="https://airspy.com/?ddownload=${SPYSERVER_ARM64_ID}"  ;; \
    "linux/arm/v7")  FILE_URL="https://airspy.com/?ddownload=${SPYSERVER_ARMHF_ID}"  ;; \
    *) exit 1 ;;\
  esac && \
  curl -o /tmp/spyserver.tar.gz -L "$FILE_URL" && \
  tar xfz /tmp/spyserver.tar.gz -C /app && \
  rm /tmp/spyserver.tar.gz && \
  cp /app/spyserver.config /config

#
#	Add local files to image
#
COPY root/ /

ENTRYPOINT ["/init"]
