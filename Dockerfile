FROM        aemdesign/oracle-jdk:jdk11

MAINTAINER  devops <devops@aem.design>

LABEL   os="centos 8" \
        container.description="java and ffmpeg" \
        image.source="https://github.com/jrottenberg/ffmpeg/tree/master/docker-images" \
        version="1.0.0" \
        imagename="java-ffmpeg" \
        test.command=" java -version 2>&1 | grep 'java version' | sed -e 's/.*java version "\(.*\)".*/\1/'" \
        test.command.verify="11."

ARG         PKG_CONFIG_PATH=/opt/ffmpeg/lib/pkgconfig
ARG         LD_LIBRARY_PATH=/opt/ffmpeg/lib
ARG         PREFIX=/opt/ffmpeg
ARG         MAKEFLAGS="-j2"

ENV         FFMPEG_VERSION="4.2.1" \
            AOM_VERSION="dd36e78d825fb2034ea0e3c630cd43360f241021" \
            FDKAAC_VERSION="0.1.5" \
            FONTCONFIG_VERSION="2.12.4" \
            FFMPEG_GPGKEY="D67658D8" \
            FRIBIDI_VERSION="0.19.7" \
            FRIBIDI_SHA256SUM="3fc96fa9473bd31dcb5500bdf1aa78b337ba13eb8c301e7c28923fea982453a8" \
            KVAZAAR_VERSION="1.2.0" \
            FREETYPE_VERSION="2.9.1" \
            FREETYPE_SHA256SUM="ec391504e55498adceb30baceebd147a6e963f636eb617424bcfc47a169898ce" \
            LAME_MAJORVERSION="3.100" \
            LAME_VERSION="3.100" \
            LIBASS_VERSION="0.13.7" \
            LIBASS_SHA256SUM="8fadf294bf701300d4605e6f1d92929304187fca4b8d8a47889315526adbafd7" \
            LIBVIDSTAB_VERSION="1.1.0" \
            LIBVIDSTAB_SHA256SUM="14d2a053e56edad4f397be0cb3ef8eb1ec3150404ce99a426c4eb641861dc0bb" \
            OGG_VERSION="1.3.2" \
            OGG_SHA256="e19ee34711d7af328cb26287f4137e70630e7261b17cbe3cd41011d73a654692" \
            OPENCOREAMR_VERSION="0.1.5" \
            OPUS_VERSION="1.2" \
            OPUS_SHA256="77db45a87b51578fbc49555ef1b10926179861d854eb2613207dc79d9ec0a9a9" \
            OPENJPEG_VERSION="2.1.2" \
            THEORA_VERSION="1.1.1" \
            THEORA_SHA256="40952956c47811928d1e7922cda3bc1f427eb75680c3c37249c91e949054916b" \
            VORBIS_VERSION="1.3.5" \
            VORBIS_SHA256="6efbcecdd3e5dfbf090341b485da9d176eb250d893e3eb378c428a2db38301ce" \
            VPX_VERSION="1.8.0" \
            X264_VERSION="20170226-2245-stable" \
            X265_VERSION="2.3" \
            XVID_VERSION="1.3.5" \
            XVID_SHA256="165ba6a2a447a8375f7b06db5a3c91810181f2898166e7c8137401d7fc894cf0" \
            YASM_VERSION="1.3.0" \
            NASM_VERSION="2.14.02" \
            YASM_VERSION="1.3.0" \
            GPERF_VERSION="3.0.4" \
            SRC="/usr/local"

ENV         OGG_SHA256SUM="${OGG_SHA256}  libogg-${OGG_VERSION}.tar.gz" \
            OPUS_SHA256SUM="${OPUS_SHA256}  opus-${OPUS_VERSION}.tar.gz" \
            THEORA_SHA256SUM="${THEORA_SHA256}  libtheora-${THEORA_VERSION}.tar.gz" \
            VORBIS_SHA256SUM="${VORBIS_SHA256}  libvorbis-${VORBIS_VERSION}.tar.gz" \
            XVID_SHA256SUM="${XVID_SHA256}  xvidcore-${XVID_VERSION}.tar.gz" \
            FREETYPE_SHA256SUM="${FREETYPE_SHA256SUM}  freetype-${FREETYPE_VERSION}.tar.gz" \
            LIBVIDSTAB_SHA256SUM="${LIBVIDSTAB_SHA256SUM}  v${LIBVIDSTAB_VERSION}.tar.gz" \
            LIBASS_SHA256SUM="${LIBASS_SHA256SUM}  ${LIBASS_VERSION}.tar.gz" \
            FRIBIDI_SHA256SUM="${FRIBIDI_SHA256SUM}  fribidi-${FRIBIDI_VERSION}.tar.gz" \
            PATH="$PATH:${PREFIX}/bin"

WORKDIR     /tmp/workdir

#https://docs.google.com/uc?id=0B3Uxax626E5DOVdJNjc0TW9Mbmc&export=download
COPY        msft-fonts.zip ./

RUN     \
        buildDeps="autoconf \
                   automake \
                   bzip2 \
                   expat-devel \
                   gcc \
                   gcc-c++ \
                   git \
                   libtool \
                   make \
                   perl \
                   openssl-devel \
                   tar \
                   diffutils \
                   which \
                   zlib-devel \
                   freetype-devel \
                   cmake3 \
                   pkgconfig \
                   expat-devel \
                   libgomp \
                   libXext-devel \
                   libXfixes-devel \
                   unzip \
                   wget" && \
        echo "${SRC}/lib" > /etc/ld.so.conf.d/libc.conf && \
        yum install -y --enablerepo=extras epel-release && \
        yum install -y ${buildDeps}

# SETUP BUILD DEPENDECIES FROM SROUCE
RUN  \
## gperf https://www.gnu.org/software/gperf/
        DIR=$(mktemp -d) && cd ${DIR} && \
        curl -sL http://ftp.gnu.org/gnu/gperf/gperf-${GPERF_VERSION}.tar.gz | \
        tar -zx --strip-components=1 && \
        ./configure --prefix="${PREFIX}" --bindir="${PREFIX}/bin" && \
        make && \
        make install && \
        rm -rf ${DIR} && \
## nasm https://www.nasm.us/
        DIR=$(mktemp -d) && cd ${DIR} && \
        curl -sL https://www.nasm.us/pub/nasm/releasebuilds/${NASM_VERSION}/nasm-${NASM_VERSION}.tar.gz | \
        tar -zx --strip-components=1 && \
        ./autogen.sh && \
        ./configure --prefix="${PREFIX}" --bindir="${PREFIX}/bin" && \
        make && \
        make install && \
        rm -rf ${DIR} && \
        \
## yasm https://www.tortall.net
        DIR=$(mktemp -d) && cd ${DIR} && \
        curl -sL https://www.tortall.net/projects/yasm/releases/yasm-${YASM_VERSION}.tar.gz | \
        tar -zx --strip-components=1 && \
        ./configure --prefix="${PREFIX}" --bindir="${PREFIX}/bin" && \
        make && \
        make install && \
        rm -rf ${DIR}

# SETUP FFMPEG LIBRARIES AND FFMPEG
RUN  \
## opencore-amr https://sourceforge.net/projects/opencore-amr/
        DIR=$(mktemp -d) && cd ${DIR} && \
        curl -sL https://sourceforge.mirrorservice.org/o/op/opencore-amr/opencore-amr/opencore-amr-${OPENCOREAMR_VERSION}.tar.gz | \
        tar -zx --strip-components=1 && \
        ./configure --prefix="${PREFIX}" --enable-shared && \
        make && \
        make install && \
        rm -rf ${DIR} && \
#RUN  \
## x264 http://www.videolan.org/developers/x264.html
        DIR=$(mktemp -d) && cd ${DIR} && \
        curl -sL https://download.videolan.org/pub/videolan/x264/snapshots/x264-snapshot-${X264_VERSION}.tar.bz2 | \
        tar -jx --strip-components=1 && \
        ./configure --prefix="${PREFIX}" --enable-shared --enable-pic --disable-cli && \
        make && \
        make install && \
        rm -rf ${DIR} && \
#RUN  \
## x265 http://x265.org/
        DIR=$(mktemp -d) && cd ${DIR} && \
        curl -sL https://download.videolan.org/pub/videolan/x265/x265_${X265_VERSION}.tar.gz  | \
        tar -zx && \
        cd x265_${X265_VERSION}/build/linux && \
        sed -i "/-DEXTRA_LIB/ s/$/ -DCMAKE_INSTALL_PREFIX=\${PREFIX}/" multilib.sh && \
        sed -i "/^cmake/ s/$/ -DENABLE_CLI=OFF/" multilib.sh && \
        ./multilib.sh && \
        make -C 8bit install && \
        rm -rf ${DIR} && \
#RUN  \
## libogg https://www.xiph.org/ogg/
        DIR=$(mktemp -d) && cd ${DIR} && \
        curl -sLO http://downloads.xiph.org/releases/ogg/libogg-${OGG_VERSION}.tar.gz && \
        echo ${OGG_SHA256SUM} | sha256sum --check && \
        tar -zx --strip-components=1 -f libogg-${OGG_VERSION}.tar.gz && \
        ./configure --prefix="${PREFIX}" --enable-shared && \
        make && \
        make install && \
        rm -rf ${DIR} && \
#RUN  \
## libopus https://www.opus-codec.org/
        DIR=$(mktemp -d) && cd ${DIR} && \
        curl -sLO http://downloads.xiph.org/releases/opus/opus-${OPUS_VERSION}.tar.gz && \
        echo ${OPUS_SHA256SUM} | sha256sum --check && \
        tar -zx --strip-components=1 -f opus-${OPUS_VERSION}.tar.gz && \
        autoreconf -fiv && \
        ./configure --prefix="${PREFIX}" --enable-shared && \
        make && \
        make install && \
        rm -rf ${DIR} && \
#RUN  \
## libvorbis https://xiph.org/vorbis/
        DIR=$(mktemp -d) && cd ${DIR} && \
        curl -sLO http://downloads.xiph.org/releases/vorbis/libvorbis-${VORBIS_VERSION}.tar.gz && \
        echo ${VORBIS_SHA256SUM} | sha256sum --check && \
        tar -zx --strip-components=1 -f libvorbis-${VORBIS_VERSION}.tar.gz && \
        ./configure --prefix="${PREFIX}" --with-ogg="${PREFIX}" --enable-shared && \
        make && \
        make install && \
        rm -rf ${DIR} && \
#RUN  \
## libtheora http://www.theora.org/
        DIR=$(mktemp -d) && cd ${DIR} && \
        curl -sLO http://downloads.xiph.org/releases/theora/libtheora-${THEORA_VERSION}.tar.gz && \
        echo ${THEORA_SHA256SUM} | sha256sum --check && \
        tar -zx --strip-components=1 -f libtheora-${THEORA_VERSION}.tar.gz && \
        ./configure --prefix="${PREFIX}" --with-ogg="${PREFIX}" --enable-shared --disable-examples && \
        make && \
        make install && \
        rm -rf ${DIR} && \
#RUN  \
## libvpx https://www.webmproject.org/code/
        DIR=$(mktemp -d) && cd ${DIR} && \
        curl -sL https://codeload.github.com/webmproject/libvpx/tar.gz/v${VPX_VERSION} | \
        tar -zx --strip-components=1 && \
        ./configure --prefix="${PREFIX}" --enable-vp8 --enable-vp9 --enable-pic --enable-shared \
        --disable-debug --disable-examples --disable-docs --disable-install-bins  && \
        make && \
        make install && \
        rm -rf ${DIR} && \
#RUN  \
## libmp3lame http://lame.sourceforge.net/
        DIR=$(mktemp -d) && cd ${DIR} && \
        curl -sL https://sourceforge.mirrorservice.org/l/la/lame/lame/${LAME_MAJORVERSION}/lame-${LAME_VERSION}.tar.gz | \
        tar -zx --strip-components=1 && \
        ./configure --prefix="${PREFIX}" --bindir="${PREFIX}/bin" --enable-shared --enable-nasm --disable-frontend && \
        make && \
        make install && \
        rm -rf ${DIR} && \
#RUN  \
## xvid https://www.xvid.com/
        DIR=$(mktemp -d) && cd ${DIR} && \
        curl -sLO http://downloads.xvid.org/downloads/xvidcore-${XVID_VERSION}.tar.gz && \
        echo ${XVID_SHA256SUM} | sha256sum --check && \
        tar -zx -f xvidcore-${XVID_VERSION}.tar.gz && \
        cd xvidcore/build/generic && \
        ./configure --prefix="${PREFIX}" --bindir="${PREFIX}/bin" --datadir="${DIR}" && \
        make && \
        make install && \
        rm -rf ${DIR} && \
#RUN  \
## fdk-aac https://github.com/mstorsjo/fdk-aac
        DIR=$(mktemp -d) && cd ${DIR} && \
        curl -sL https://github.com/mstorsjo/fdk-aac/archive/v${FDKAAC_VERSION}.tar.gz | \
        tar -zx --strip-components=1 && \
        autoreconf -fiv && \
        ./configure --prefix="${PREFIX}" --enable-shared --datadir="${DIR}" && \
        make && \
        make install && \
        make distclean && \
        rm -rf ${DIR} && \
#RUN \
## openjpeg https://github.com/uclouvain/openjpeg
        DIR=$(mktemp -d) && cd ${DIR} && \
        curl -sL https://github.com/uclouvain/openjpeg/archive/v${OPENJPEG_VERSION}.tar.gz | \
        tar -zx --strip-components=1 && \
        cmake -DBUILD_THIRDPARTY:BOOL=ON -DCMAKE_INSTALL_PREFIX="${PREFIX}" . && \
        make && \
        make install && \
        rm -rf ${DIR} && \
#RUN  \
## freetype https://www.freetype.org/
        DIR=$(mktemp -d) && cd ${DIR} && \
        curl -sLO http://download.savannah.gnu.org/releases/freetype/freetype-${FREETYPE_VERSION}.tar.gz && \
        echo ${FREETYPE_SHA256SUM} | sha256sum --check && \
        tar -zx --strip-components=1 -f freetype-${FREETYPE_VERSION}.tar.gz && \
        ./configure --prefix="${PREFIX}" --disable-static --enable-shared && \
        make && \
        make install && \
        rm -rf ${DIR} && \
#RUN  \
## libvstab https://github.com/georgmartius/vid.stab
        DIR=$(mktemp -d) && cd ${DIR} && \
        curl -sLO https://github.com/georgmartius/vid.stab/archive/v${LIBVIDSTAB_VERSION}.tar.gz &&\
        echo ${LIBVIDSTAB_SHA256SUM} | sha256sum --check && \
        tar -zx --strip-components=1 -f v${LIBVIDSTAB_VERSION}.tar.gz && \
        cmake -DCMAKE_INSTALL_PREFIX="${PREFIX}" . && \
        make && \
        make install && \
        rm -rf ${DIR} && \
#RUN  \
## fridibi https://www.fribidi.org/
        DIR=$(mktemp -d) && cd ${DIR} && \
        curl -sL -o fribidi-${FRIBIDI_VERSION}.tar.gz https://codeload.github.com/fribidi/fribidi/tar.gz/${FRIBIDI_VERSION} &&\
        echo ${FRIBIDI_SHA256SUM} | sha256sum --check && \
        tar -zx --strip-components=1 -f fribidi-${FRIBIDI_VERSION}.tar.gz && \
        sed -i 's/^SUBDIRS =.*/SUBDIRS=gen.tab charset lib/' Makefile.am && \
        ./bootstrap --no-config && \
        ./configure -prefix="${PREFIX}" --disable-static --enable-shared && \
        make && \
        make install && \
        rm -rf ${DIR} && \
#RUN  \
## fontconfig https://www.freedesktop.org/wiki/Software/fontconfig/
        DIR=$(mktemp -d) && cd ${DIR} && \
        curl -sLO https://www.freedesktop.org/software/fontconfig/release/fontconfig-${FONTCONFIG_VERSION}.tar.bz2 &&\
        tar -jx --strip-components=1 -f fontconfig-${FONTCONFIG_VERSION}.tar.bz2 && \
        ./configure -prefix="${PREFIX}" --disable-static --enable-shared && \
        make && \
        make install && \
        rm -rf ${DIR} && \
#RUN  \
## libass https://github.com/libass/libass
        DIR=$(mktemp -d) && cd ${DIR} && \
        curl -sLO https://github.com/libass/libass/archive/${LIBASS_VERSION}.tar.gz &&\
        echo ${LIBASS_SHA256SUM} | sha256sum --check && \
        tar -zx --strip-components=1 -f ${LIBASS_VERSION}.tar.gz && \
        ./autogen.sh && \
        ./configure -prefix="${PREFIX}" --disable-static --enable-shared && \
        make && \
        make install && \
        rm -rf ${DIR} && \
#RUN \
## kvazaar https://github.com/ultravideo/kvazaar
        DIR=$(mktemp -d) && cd ${DIR} && \
        curl -sLO https://github.com/ultravideo/kvazaar/archive/v${KVAZAAR_VERSION}.tar.gz &&\
        tar -zx --strip-components=1 -f v${KVAZAAR_VERSION}.tar.gz && \
        ./autogen.sh && \
        ./configure -prefix="${PREFIX}" --disable-static --enable-shared && \
        make && \
        make install && \
        rm -rf ${DIR} && \
#RUN \
## aomedia https://aomedia.googlesource.com/aom/
        DIR=$(mktemp -d) && cd ${DIR} && \
        curl -sLO https://aomedia.googlesource.com/aom/+archive/${AOM_VERSION}.tar.gz && \
        tar -zx -f ${AOM_VERSION}.tar.gz && \
        rm -rf CMakeCache.txt CMakeFiles && \
        mkdir -p ./aom_build && \
        cd ./aom_build && \
        cmake -DCMAKE_INSTALL_PREFIX="${PREFIX}" -DBUILD_SHARED_LIBS=1 -DENABLE_DOCS=0 .. && \
        make && \
        make install && \
        rm -rf ${DIR} && \
#RUN  \
## ffmpeg https://ffmpeg.org/
        DIR=$(mktemp -d) && cd ${DIR} && \
        curl -sLO https://ffmpeg.org/releases/ffmpeg-${FFMPEG_VERSION}.tar.bz2 && \
        tar -jx --strip-components=1 -f ffmpeg-${FFMPEG_VERSION}.tar.bz2 && \
        ./configure \
        --disable-debug \
        --disable-doc \
        --disable-ffplay \
        --disable-examples \
        --disable-unit-tests \
        --enable-shared \
        --enable-avresample \
        --enable-libopencore-amrnb \
        --enable-libopencore-amrwb \
        --enable-gpl \
        --enable-libass \
        --enable-libfreetype \
        --enable-libvidstab \
        --enable-libmp3lame \
        --enable-libopenjpeg \
        --enable-libopus \
        --enable-libtheora \
        --enable-libvorbis \
        --enable-libvpx \
        --enable-libwebp \
        --enable-libx264 \
        --enable-libx265 \
        --enable-libxvid \
        --enable-x86asm \
        --enable-gpl \
        --enable-libx264 \
        --enable-nonfree \
        --enable-openssl \
        --enable-libfdk_aac \
        --enable-libfdk-aac \
        --enable-libkvazaar \
        --enable-libaom --extra-libs=-lpthread \
        --enable-postproc \
        --enable-small \
        --enable-version3 \
        --enable-zlib \
        --extra-cflags="-I${PREFIX}/include" \
        --extra-ldflags="-L${PREFIX}/lib" \
        --extra-libs=-ldl \
        --prefix="${PREFIX}" && \
        echo "#disable all tests">tests/Makefile && \
        make && \
        make install && \
        make distclean && \
        hash -r && \
        cd tools && \
        make qt-faststart && \
        cp qt-faststart ${PREFIX}/bin && \
        rm -rf ${DIR} && \
#RUN \
## setup ffmpeg lib64 libs
        ldd ${PREFIX}/bin/ffmpeg | grep opt/ffmpeg | cut -d ' ' -f 3 | xargs -i cp {} /usr/local/lib64/ && \
        cp ${PREFIX}/bin/* /usr/local/bin/ && \
        cp -r ${PREFIX}/share/ffmpeg /usr/local/share/ && \
        LD_LIBRARY_PATH=/usr/local/lib64 ffmpeg -buildconf && \
        ldconfig -v && ffmpeg -buildconf && \
#RUN \
## setup jre fallback fonts
        mkdir -p /usr/java/default/jre/lib/fonts/fallback && \
        ln -s /usr/share/fonts/cjkuni-ukai/ukai.ttc /usr/java/default/jre/lib/fonts/fallback && \
        ln -s /usr/share/fonts/cjkuni-uming/uming.ttc /usr/java/default/jre/lib/fonts/fallback && \
        cd /tmp/workdir && unzip msft-fonts.zip && cp msft-fonts/* /usr/java/default/jre/lib/fonts/fallback/ && \
        rm -fr /tmp/workdir/msft-fonts /tmp/workdir/msft-fonts.zip && \
#RUN \
## clenaup
        yum clean all && rm -rf /var/lib/yum/*

ENV     LD_LIBRARY_PATH=/usr/local/lib64
