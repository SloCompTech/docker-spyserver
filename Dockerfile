#
#	Base image
#	@see https://github.com/SloCompTech/docker-baseimage	
#
FROM slocomptech/bi-ubuntu:bionic

#
#	Arguments
#
ARG BUILD_DATE
ARG VCS_REF
ARG VCS_SRC
ARG VERSION

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
		apt install -y \
			rtl-sdr \
			librtlsdr-dev

RUN curl -o /tmp/spyserver.tar.gz -L "https://airspy.com/downloads/spyserver-linux-x64.tgz" && \
	tar xfz /tmp/spyserver.tar.gz -C /app && \
	rm /tmp/spyserver.tar.gz && \
  mv /app/spyserver.config /defaults

# Install RTL-SDR v4 Driver
RUN apt install -y \
      libusb-1.0-0-dev \
      git \
      cmake \
      pkg-config && \
    cd /tmp && \
    git clone https://github.com/rtlsdrblog/rtl-sdr-blog && \
    cd rtl-sdr-blog && \
    mkdir build && \
    cd build && \
    cmake ../ -DINSTALL_UDEV_RULES=ON && \
    make && \
    sudo make install && \
    sudo cp ../rtl-sdr.rules /etc/udev/rules.d/ && \
    sudo ldconfig && \
    echo 'blacklist dvb_usb_rtl28xxu' | sudo tee --append /etc/modprobe.d/blacklist-dvb_usb_rtl28xxu.conf && \
    apt remove --autoremove -y \
      git \
      cmake \
      pkg-config && \
    rm -r /tmp/rtl-sdr-blog

#
#	Add local files to image
#
COPY root/ /
