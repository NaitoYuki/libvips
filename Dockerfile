# ベースとなるイメージを指定
FROM arm64v8/ubuntu:latest

# 必要なパッケージのインストール
RUN apt-get update && apt-get install -y \
    build-essential \
    wget \
    meson \
    ninja-build \
    pkg-config \
    glib2.0-dev \
    libgirepository1.0-dev \
    libglib2.0-dev \
    libjpeg-turbo8-dev \
    libpng-dev \
    libwebp-dev \
    libtiff5-dev \
    libexif-dev \
    libgsf-1-dev \
    liblcms2-dev \
    libxml2-dev \
    libheif-dev \
    swig \
    python3-dev \
    python3-numpy \
    libmagickwand-dev \
    libpango1.0-dev \
    libmatio-dev \
    libopenslide-dev \
    libcfitsio-dev \
    libgif-dev \
    libpoppler-glib-dev \
    librsvg2-dev \
    libtiff-tools \
    fftw3-dev \
    liborc-0.4-dev \
    liblcms2-dev \
    libzstd-dev \
    libimagequant-dev \
    libgs-dev \
    libpango1.0-dev \
    libmatio-dev \
    xz-utils \
    autoconf \
    automake \
    libtool \
    git \
    cmake

RUN git clone https://github.com/strukturag/libde265.git && \
    cd libde265 && \
    ./autogen.sh && \
    ./configure && \
    make

RUN git clone https://github.com/videolan/x265.git && \
    cd x265/build && \
    cmake ../source && \
    make && \
    make install

# libvips のソースのダウンロード
WORKDIR /tmp
RUN wget https://github.com/libvips/libvips/releases/download/v8.14.5/vips-8.14.5.tar.xz
RUN tar xf vips-8.14.5.tar.xz

# libvips のビルド
WORKDIR /tmp/vips-8.14.5
RUN cd /tmp/vips-8.14.5
RUN meson _build
RUN ninja -C _build
RUN ninja -C _build install
RUN ldconfig

# ビルドしたバイナリを保存するディレクトリを作成
WORKDIR /output
RUN cp /usr/local/bin/vips /output/
