FROM ubuntu:22.04

RUN mkdir /app

ARG DEBIAN_FRONTEND=noninteractive

WORKDIR /app

RUN apt-get update && apt-get install -y \
        build-essential \
        wget \
        git \
        pkg-config \
        curl

RUN apt-get install -y python3 python3-pip python3-setuptools python3-wheel
RUN pip3 install meson ninja

RUN apt-get install -y \
        libexpat1-dev \
        librsvg2-dev \
        libpng-dev \
        libjpeg-dev \
        libwebp-dev \
        libheif-dev \
        libexif-dev \
        liblcms2-dev \
        libglib2.0-dev \
        liborc-dev \
        libgif-dev \
        libgirepository1.0-dev \
        libcgif-dev \
        libcgif0 \
        libimagequant-dev \
        gettext

RUN export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH

ARG VIPS_VER=8.14.5
ARG VIPS_DLURL=https://github.com/libvips/libvips/releases/download
RUN cd /usr/local/src \
        && wget ${VIPS_DLURL}/v${VIPS_VER}/vips-${VIPS_VER}.tar.xz \
        && tar xf vips-${VIPS_VER}.tar.xz \
        && cd vips-${VIPS_VER} \
        && meson setup build --buildtype=release -Dcgif=enabled \
        && cd build \
        && meson compile \
        && meson test \
        && meson install
RUN ldconfig

WORKDIR /output
RUN cp /usr/local/bin/vips /output/
