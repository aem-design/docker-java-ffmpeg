FROM        aemdesign/oracle-jdk:jdk8-arm

LABEL   os="centos 8" \
        container.description="java and ffmpeg" \
        image.source="https://github.com/jrottenberg/ffmpeg/tree/master/docker-images" \
        version="1.0.0" \
        maintainer="devops <devops@aem.design>" \
        imagename="java-ffmpeg" \
        test.command=" java -version 2>&1 | grep 'java version' | sed -e 's/.*java version "\(.*\)".*/\1/'" \
        test.command.verify="1.8"

WORKDIR     /tmp/workdir

ENV         FFMPEG_VERSION="4.3.2" \
            AOM_VERSION="v1.0.0" \
            FDKAAC_VERSION="0.1.5" \
            FONTCONFIG_VERSION="2.12.4" \
            FFMPEG_GPGKEY="D67658D8" \
            FREETYPE_VERSION="2.9.1" \
            FREETYPE_SHA256="ec391504e55498adceb30baceebd147a6e963f636eb617424bcfc47a169898ce" \
            FRIBIDI_VERSION="0.19.7" \
            FRIBIDI_SHA256="3fc96fa9473bd31dcb5500bdf1aa78b337ba13eb8c301e7c28923fea982453a8" \
            KVAZAAR_VERSION="2.0.0" \
            LAME_MAJORVERSION="3.100" \
            LAME_VERSION="3.100" \
            LIBASS_VERSION="0.13.7" \
            LIBASS_SHA256="8fadf294bf701300d4605e6f1d92929304187fca4b8d8a47889315526adbafd7" \
            LIBPTHREAD_STUBS_VERSION="0.4" \
            LIBVIDSTAB_VERSION="1.1.0" \
            LIBVIDSTAB_SHA256="14d2a053e56edad4f397be0cb3ef8eb1ec3150404ce99a426c4eb641861dc0bb" \
            LIBXCB_VERSION="1.13.1" \
            XCBPROTO_VERSION="1.13" \
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
            WEBP_VERSION="1.0.2" \
            X264_VERSION="20170226-2245-stable" \
            X265_VERSION="3.1.1" \
            XAU_VERSION="1.0.9" \
            XORG_MACROS_VERSION="1.19.2" \
            XPROTO_VERSION="7.0.31" \
            XVID_VERSION="1.3.5" \
            XVID_SHA256="165ba6a2a447a8375f7b06db5a3c91810181f2898166e7c8137401d7fc894cf0" \
            LIBXML2_VERSION="2.9.10" \
            LIBXML2_SHA256="f07dab13bf42d2b8db80620cce7419b3b87827cc937c8bb20fe13b8571ee9501" \
            LIBBLURAY_VERSION="1.1.2" \
            LIBBLURAY_SHA256="a3dd452239b100dc9da0d01b30e1692693e2a332a7d29917bf84bb10ea7c0b42" \
            LIBZMQ_VERSION="4.3.2" \
            LIBZMQ_SHA256="02ecc88466ae38cf2c8d79f09cfd2675ba299a439680b64ade733e26a349edeb" \
            LIBSRT_VERSION="1.4.1" \
            LIBARIBB24_VERSION="1.0.3" \
            LIBARIBB24_SHA256="f61560738926e57f9173510389634d8c06cabedfa857db4b28fb7704707ff128" \
            LIBPNG_VERSION="1.6.9" \
            SRC="/usr/local"

ENV         FREETYPE_SHA256SUM="${FREETYPE_SHA256} freetype-${FREETYPE_VERSION}.tar.gz" \
            FRIBIDI_SHA256SUM="${FRIBIDI_SHA256} ${FRIBIDI_VERSION}.tar.gz" \
            LIBASS_SHA256SUM="${LIBASS_SHA256} ${LIBASS_VERSION}.tar.gz" \
            LIBVIDSTAB_SHA256SUM="${LIBVIDSTAB_SHA256} v${LIBVIDSTAB_VERSION}.tar.gz" \
            OGG_SHA256SUM="${OGG_SHA256} libogg-${OGG_VERSION}.tar.gz" \
            OPUS_SHA256SUM="${OPUS_SHA256} opus-${OPUS_VERSION}.tar.gz" \
            THEORA_SHA256SUM="${THEORA_SHA256} libtheora-${THEORA_VERSION}.tar.gz" \
            VORBIS_SHA256SUM="${VORBIS_SHA256} libvorbis-${VORBIS_VERSION}.tar.gz" \
            XVID_SHA256SUM="${XVID_SHA256} xvidcore-${XVID_VERSION}.tar.gz" \
            LIBXML2_SHA256SUM="${LIBXML2_SHA256} libxml2-v${LIBXML2_VERSION}.tar.gz" \
            LIBBLURAY_SHA256SUM="${LIBBLURAY_SHA256} libbluray-${LIBBLURAY_VERSION}.tar.bz2" \
            LIBZMQ_SHA256SUM="${LIBZMQ_SHA256} v${LIBZMQ_VERSION}.tar.gz" \
            LIBARIBB24_SHA256SUM="${LIBARIBB24_SHA256} v${LIBARIBB24_VERSION}.tar.gz" \
            PATH="$PATH:${PREFIX}/bin"

ARG         PKG_CONFIG_PATH="/opt/ffmpeg/share/pkgconfig:/opt/ffmpeg/lib/pkgconfig:/opt/ffmpeg/lib64/pkgconfig"
ARG         LD_LIBRARY_PATH=/opt/ffmpeg/lib
ARG         PREFIX=/opt/ffmpeg
ARG         MAKEFLAGS="-j2"
ARG         LD_LIBRARY_PATH="/opt/ffmpeg/lib:/opt/ffmpeg/lib64"

#https://docs.google.com/uc?id=0B3Uxax626E5DOVdJNjc0TW9Mbmc&export=download
COPY        msft-fonts.zip ./

RUN         buildDeps="autoconf \
                   automake \
                   bzip2 \
                   cmake \
                   diffutils \
                   expat-devel \
                   gcc \
                   gcc-c++ \
                   git \
                   gperf \
                   libtool \
                   make \
                   nasm \
                   perl \
                   python3 \
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
                   yasm \
                   which \
                   wget \
                   libgomp" && \
        echo "${SRC}/lib" > /etc/ld.so.conf.d/libc.conf && \
        dnf update -y && \
        dnf repolist && \
        dnf --enablerepo=extras install -y epel-release dnf-plugins-core && \
        dnf config-manager --set-enabled powertools && \
        dnf --enablerepo=powertools install -y ${buildDeps} && \
        dnf repolist && \
        alternatives --set python /usr/bin/python3

# SETUP FFMPEG LIBRARIES AND FFMPEG
RUN  \
## opencore-amr https://sourceforge.net/projects/opencore-amr/
        echo ">>> BUILD: opencore-amr <<" && \
        DIR=$(mktemp -d) && cd ${DIR} && \
        curl -sL https://versaweb.dl.sourceforge.net/project/opencore-amr/opencore-amr/opencore-amr-${OPENCOREAMR_VERSION}.tar.gz | \
        tar -zx --strip-components=1 && \
        ./configure --prefix="${PREFIX}" --enable-shared && \
        make && \
        make install && \
        rm -rf ${DIR}
RUN  \
## x264 http://www.videolan.org/developers/x264.html
        echo ">>> BUILD: x264 <<" && \
        DIR=$(mktemp -d) && cd ${DIR} && \
        curl -sL https://download.videolan.org/pub/videolan/x264/snapshots/x264-snapshot-${X264_VERSION}.tar.bz2 | \
        tar -jx --strip-components=1 && \
        ./configure --prefix="${PREFIX}" --enable-shared --enable-pic --disable-cli && \
        make && \
        make install && \
        rm -rf ${DIR}
RUN  \
## x265 http://x265.org/
        echo ">>> BUILD: x265 <<" && \
        DIR=$(mktemp -d) && cd ${DIR} && \
        curl -sL https://download.videolan.org/pub/videolan/x265/x265_${X265_VERSION}.tar.gz  | \
        tar -zx && \
        cd x265_${X265_VERSION}/build/linux && \
        sed -i "/-DEXTRA_LIB/ s/$/ -DCMAKE_INSTALL_PREFIX=\${PREFIX}/" multilib.sh && \
        sed -i "/^cmake/ s/$/ -DENABLE_CLI=OFF/" multilib.sh && \
        ./multilib.sh && \
        make -C 8bit install && \
        rm -rf ${DIR}
RUN  \
## libogg https://www.xiph.org/ogg/
        echo ">>> BUILD: ogg <<" && \
        DIR=$(mktemp -d) && cd ${DIR} && \
        curl -sLO http://downloads.xiph.org/releases/ogg/libogg-${OGG_VERSION}.tar.gz && \
        echo ${OGG_SHA256SUM} | sha256sum --check && \
        tar -zx --strip-components=1 -f libogg-${OGG_VERSION}.tar.gz && \
        ./configure --prefix="${PREFIX}" --enable-shared && \
        make && \
        make install && \
        rm -rf ${DIR}
RUN  \
## libopus https://www.opus-codec.org/
        echo ">>> BUILD: opus <<" && \
        DIR=$(mktemp -d) && cd ${DIR} && \
        curl -sLO https://archive.mozilla.org/pub/opus/opus-${OPUS_VERSION}.tar.gz && \
        echo ${OPUS_SHA256SUM} | sha256sum --check && \
        tar -zx --strip-components=1 -f opus-${OPUS_VERSION}.tar.gz && \
        autoreconf -fiv && \
        ./configure --prefix="${PREFIX}" --enable-shared && \
        make && \
        make install && \
        rm -rf ${DIR}
RUN  \
## libvorbis https://xiph.org/vorbis/
        echo ">>> BUILD: vorbis <<" && \
        DIR=$(mktemp -d) && cd ${DIR} && \
        curl -sLO http://downloads.xiph.org/releases/vorbis/libvorbis-${VORBIS_VERSION}.tar.gz && \
        echo ${VORBIS_SHA256SUM} | sha256sum --check && \
        tar -zx --strip-components=1 -f libvorbis-${VORBIS_VERSION}.tar.gz && \
        ./configure --prefix="${PREFIX}" --with-ogg="${PREFIX}" --enable-shared && \
        make && \
        make install && \
        rm -rf ${DIR}
RUN  \
## libtheora http://www.theora.org/
        echo ">>> BUILD: theora <<" && \
        DIR=$(mktemp -d) && cd ${DIR} && \
        curl -sLO http://downloads.xiph.org/releases/theora/libtheora-${THEORA_VERSION}.tar.gz && \
        echo ${THEORA_SHA256SUM} | sha256sum --check && \
        tar -zx --strip-components=1 -f libtheora-${THEORA_VERSION}.tar.gz && \
        ./configure --prefix="${PREFIX}" --with-ogg="${PREFIX}" --enable-shared --disable-examples && \
        make && \
        make install && \
        rm -rf ${DIR}
RUN  \
## libvpx https://www.webmproject.org/code/
        echo ">>> BUILD: libvpx <<" && \
        DIR=$(mktemp -d) && cd ${DIR} && \
        curl -sL https://codeload.github.com/webmproject/libvpx/tar.gz/v${VPX_VERSION} | \
        tar -zx --strip-components=1 && \
        ./configure --prefix="${PREFIX}" --enable-vp8 --enable-vp9 --enable-vp9-highbitdepth --enable-pic --enable-shared \
        --disable-debug --disable-examples --disable-docs --disable-install-bins  && \
        make && \
        make install && \
        rm -rf ${DIR}
RUN \
### libwebp https://developers.google.com/speed/webp/
        echo ">>> BUILD: libwebp <<" && \
        DIR=$(mktemp -d) && cd ${DIR} && \
        curl -sL https://storage.googleapis.com/downloads.webmproject.org/releases/webp/libwebp-${WEBP_VERSION}.tar.gz | \
        tar -zx --strip-components=1 && \
        ./configure --prefix="${PREFIX}" --enable-shared  && \
        make && \
        make install && \
        rm -rf ${DIR}
RUN  \
## libmp3lame http://lame.sourceforge.net/
        echo ">>> BUILD: libmp3lame <<" && \
        DIR=$(mktemp -d) && cd ${DIR} && \
        curl -sL https://versaweb.dl.sourceforge.net/project/lame/lame/${LAME_VERSION}/lame-${LAME_VERSION}.tar.gz | \
        tar -zx --strip-components=1 && \
        ./configure --prefix="${PREFIX}" --bindir="${PREFIX}/bin" --enable-shared --enable-nasm --disable-frontend && \
        make && \
        make install && \
        rm -rf ${DIR}
RUN  \
## xvid https://www.xvid.com/
        echo ">>> BUILD: xvid <<" && \
        DIR=$(mktemp -d) && cd ${DIR} && \
        curl -sLO http://downloads.xvid.org/downloads/xvidcore-${XVID_VERSION}.tar.gz && \
        echo ${XVID_SHA256SUM} | sha256sum --check && \
        tar -zx -f xvidcore-${XVID_VERSION}.tar.gz && \
        cd xvidcore/build/generic && \
        ./configure --prefix="${PREFIX}" --bindir="${PREFIX}/bin" && \
        make && \
        make install && \
        rm -rf ${DIR}
RUN  \
## fdk-aac https://github.com/mstorsjo/fdk-aac
        echo ">>> BUILD: fdk-aac <<" && \
        DIR=$(mktemp -d) && cd ${DIR} && \
        curl -sL https://github.com/mstorsjo/fdk-aac/archive/v${FDKAAC_VERSION}.tar.gz | \
        tar -zx --strip-components=1 && \
        autoreconf -fiv && \
        ./configure --prefix="${PREFIX}" --enable-shared --datadir="${DIR}" && \
        make && \
        make install && \
        rm -rf ${DIR}
RUN \
## openjpeg https://github.com/uclouvain/openjpeg
        echo ">>> BUILD: openjpeg <<" && \
        DIR=$(mktemp -d) && cd ${DIR} && \
        curl -sL https://github.com/uclouvain/openjpeg/archive/v${OPENJPEG_VERSION}.tar.gz | \
        tar -zx --strip-components=1 && \
        cmake -DBUILD_THIRDPARTY:BOOL=ON -DCMAKE_INSTALL_PREFIX="${PREFIX}" . && \
        make && \
        make install && \
        rm -rf ${DIR}
RUN  \
## freetype https://www.freetype.org/
        echo ">>> BUILD: freetype <<" && \
        DIR=$(mktemp -d) && cd ${DIR} && \
        curl -sLO https://download.savannah.gnu.org/releases/freetype/freetype-${FREETYPE_VERSION}.tar.gz && \
        echo ${FREETYPE_SHA256SUM} | sha256sum --check && \
        tar -zx --strip-components=1 -f freetype-${FREETYPE_VERSION}.tar.gz && \
        ./configure --prefix="${PREFIX}" --disable-static --enable-shared && \
        make && \
        make install && \
        rm -rf ${DIR}
RUN  \
## libvstab https://github.com/georgmartius/vid.stab
        echo ">>> BUILD: libvstab <<" && \
        DIR=$(mktemp -d) && cd ${DIR} && \
        curl -sLO https://github.com/georgmartius/vid.stab/archive/v${LIBVIDSTAB_VERSION}.tar.gz && \
        echo ${LIBVIDSTAB_SHA256SUM} | sha256sum --check && \
        tar -zx --strip-components=1 -f v${LIBVIDSTAB_VERSION}.tar.gz && \
        cmake -DCMAKE_INSTALL_PREFIX="${PREFIX}" . && \
        make && \
        make install && \
        rm -rf ${DIR}
RUN  \
## fridibi https://www.fribidi.org/
        echo ">>> BUILD: fribidi <<" && \
        DIR=$(mktemp -d) && cd ${DIR} && \
        curl -sLO https://github.com/fribidi/fribidi/archive/${FRIBIDI_VERSION}.tar.gz && \
        echo ${FRIBIDI_SHA256SUM} | sha256sum --check && \
        tar -zx --strip-components=1 -f ${FRIBIDI_VERSION}.tar.gz && \
        sed -i 's/^SUBDIRS =.*/SUBDIRS=gen.tab charset lib bin/' Makefile.am && \
        ./bootstrap --no-config --auto && \
        ./configure --prefix="${PREFIX}" --disable-static --enable-shared && \
        make -j1 && \
        make install && \
        rm -rf ${DIR}
RUN  \
## fontconfig https://www.freedesktop.org/wiki/Software/fontconfig/
        echo ">>> BUILD: fontconfig <<" && \
        DIR=$(mktemp -d) && cd ${DIR} && \
        curl -sLO https://www.freedesktop.org/software/fontconfig/release/fontconfig-${FONTCONFIG_VERSION}.tar.bz2 && \
        tar -jx --strip-components=1 -f fontconfig-${FONTCONFIG_VERSION}.tar.bz2 && \
        ./configure --prefix="${PREFIX}" --disable-static --enable-shared && \
        make && \
        make install && \
        rm -rf ${DIR}
RUN  \
## libass https://github.com/libass/libass
        echo ">>> BUILD: libass <<" && \
        DIR=$(mktemp -d) && cd ${DIR} && \
        curl -sLO https://github.com/libass/libass/archive/${LIBASS_VERSION}.tar.gz && \
        echo ${LIBASS_SHA256SUM} | sha256sum --check && \
        tar -zx --strip-components=1 -f ${LIBASS_VERSION}.tar.gz && \
        ./autogen.sh && \
        ./configure --prefix="${PREFIX}" --disable-static --enable-shared && \
        make && \
        make install && \
        rm -rf ${DIR}
RUN \
## kvazaar https://github.com/ultravideo/kvazaar
        echo ">>> BUILD: kvazaar <<" && \
        DIR=$(mktemp -d) && cd ${DIR} && \
        curl -sLO https://github.com/ultravideo/kvazaar/archive/v${KVAZAAR_VERSION}.tar.gz && \
        tar -zx --strip-components=1 -f v${KVAZAAR_VERSION}.tar.gz && \
        ./autogen.sh && \
        ./configure --prefix="${PREFIX}" --disable-static --enable-shared && \
        make && \
        make install && \
        rm -rf ${DIR}

RUN \
## aomedia https://aomedia.googlesource.com/aom/
        echo ">>> BUILD: aomedia <<" && \
        DIR=$(mktemp -d) && \
        git clone --branch ${AOM_VERSION} --depth 1 https://aomedia.googlesource.com/aom ${DIR} && \
        cd ${DIR} && \
        rm -rf CMakeCache.txt CMakeFiles && \
        mkdir -p ./aom_build && \
        cd ./aom_build && \
        cmake -DCMAKE_INSTALL_PREFIX="${PREFIX}" -DBUILD_SHARED_LIBS=1 .. && \
        make && \
        make install && \
        rm -rf ${DIR}

RUN \
## libxcb (and supporting libraries) for screen capture https://xcb.freedesktop.org/
        echo ">>> BUILD: libxcb <<" && \
        DIR=$(mktemp -d) && cd ${DIR} && \
        curl -sLO https://www.x.org/archive//individual/util/util-macros-${XORG_MACROS_VERSION}.tar.gz && \
        tar -zx --strip-components=1 -f util-macros-${XORG_MACROS_VERSION}.tar.gz && \
        ./configure --srcdir=${DIR} --prefix="${PREFIX}" && \
        make && \
        make install && \
        rm -rf ${DIR}

RUN \
        echo ">>> BUILD: xproto <<" && \
        DIR=$(mktemp -d) && cd ${DIR} && \
        curl -sLO https://www.x.org/archive/individual/proto/xproto-${XPROTO_VERSION}.tar.gz && \
        tar -zx --strip-components=1 -f xproto-${XPROTO_VERSION}.tar.gz && \
        ./configure --srcdir=${DIR} --prefix="${PREFIX}" && \
        make && \
        make install && \
        rm -rf ${DIR}

RUN \
        echo ">>> BUILD: libXau <<" && \
        DIR=$(mktemp -d) && cd ${DIR} && \
        curl -sLO https://www.x.org/archive/individual/lib/libXau-${XAU_VERSION}.tar.gz && \
        tar -zx --strip-components=1 -f libXau-${XAU_VERSION}.tar.gz && \
        ./configure --srcdir=${DIR} --prefix="${PREFIX}" && \
        make && \
        make install && \
        rm -rf ${DIR}

RUN \
        echo ">>> BUILD: libpthread <<" && \
        DIR=$(mktemp -d) && cd ${DIR} && \
        curl -sLO https://xcb.freedesktop.org/dist/libpthread-stubs-${LIBPTHREAD_STUBS_VERSION}.tar.gz && \
        tar -zx --strip-components=1 -f libpthread-stubs-${LIBPTHREAD_STUBS_VERSION}.tar.gz && \
        ./configure --prefix="${PREFIX}" && \
        make && \
        make install && \
        rm -rf ${DIR}

RUN \
        echo ">>> BUILD: xcb-proto <<" && \
        DIR=$(mktemp -d) && cd ${DIR} && \
        curl -sLO https://xcb.freedesktop.org/dist/xcb-proto-${XCBPROTO_VERSION}.tar.gz && \
        tar -zx --strip-components=1 -f xcb-proto-${XCBPROTO_VERSION}.tar.gz && \
        ACLOCAL_PATH="${PREFIX}/share/aclocal" ./autogen.sh && \
        ./configure --prefix="${PREFIX}" && \
        make && \
        make install && \
        rm -rf ${DIR}

RUN \
        echo ">>> BUILD: libxcb <<" && \
        DIR=$(mktemp -d) && cd ${DIR} && \
        curl -sLO https://xcb.freedesktop.org/dist/libxcb-${LIBXCB_VERSION}.tar.gz && \
        tar -zx --strip-components=1 -f libxcb-${LIBXCB_VERSION}.tar.gz && \
        ACLOCAL_PATH="${PREFIX}/share/aclocal" ./autogen.sh && \
        ./configure --prefix="${PREFIX}" --disable-static --enable-shared && \
        make && \
        make install && \
        rm -rf ${DIR}

RUN \
## libxml2 - for libbluray
        echo ">>> BUILD: libxml2 <<" && \
        DIR=$(mktemp -d) && cd ${DIR} && \
        curl -sLO https://gitlab.gnome.org/GNOME/libxml2/-/archive/v${LIBXML2_VERSION}/libxml2-v${LIBXML2_VERSION}.tar.gz && \
        echo ${LIBXML2_SHA256SUM} | sha256sum --check && \
        tar -xz --strip-components=1 -f libxml2-v${LIBXML2_VERSION}.tar.gz && \
        ./autogen.sh --prefix="${PREFIX}" --with-ftp=no --with-http=no --with-python=no && \
        make && \
        make install && \
        rm -rf ${DIR}

RUN \
## libbluray - Requires libxml, freetype, and fontconfig
        echo ">>> BUILD: libbluray <<" && \
        DIR=$(mktemp -d) && cd ${DIR} && \
        curl -sLO https://download.videolan.org/pub/videolan/libbluray/${LIBBLURAY_VERSION}/libbluray-${LIBBLURAY_VERSION}.tar.bz2 && \
        echo ${LIBBLURAY_SHA256SUM} | sha256sum --check && \
        tar -jx --strip-components=1 -f libbluray-${LIBBLURAY_VERSION}.tar.bz2 && \
        ./configure --prefix="${PREFIX}" --disable-examples --disable-bdjava-jar --disable-static --enable-shared && \
        make && \
        make install && \
        rm -rf ${DIR}

RUN \
## libzmq https://github.com/zeromq/libzmq/
        echo ">>> BUILD: libzmq <<" && \
        DIR=$(mktemp -d) && cd ${DIR} && \
        curl -sLO https://github.com/zeromq/libzmq/archive/v${LIBZMQ_VERSION}.tar.gz && \
        echo ${LIBZMQ_SHA256SUM} | sha256sum --check && \
        tar -xz --strip-components=1 -f v${LIBZMQ_VERSION}.tar.gz && \
        ./autogen.sh && \
        ./configure --prefix="${PREFIX}" && \
        make && \
        make check && \
        make install && \
        rm -rf ${DIR}

RUN \
## libsrt https://github.com/Haivision/srt
        echo ">>> BUILD: libsrt <<" && \
        DIR=$(mktemp -d) && cd ${DIR} && \
        curl -sLO https://github.com/Haivision/srt/archive/v${LIBSRT_VERSION}.tar.gz && \
        tar -xz --strip-components=1 -f v${LIBSRT_VERSION}.tar.gz && \
        cmake -DCMAKE_INSTALL_PREFIX="${PREFIX}" . && \
        make && \
        make install && \
        rm -rf ${DIR}

RUN \
## libpng
        echo ">>> BUILD: libpng <<" && \
        DIR=$(mktemp -d) && cd ${DIR} && \
        git clone https://git.code.sf.net/p/libpng/code ${DIR} -b v${LIBPNG_VERSION} --depth 1 && \
        ./autogen.sh && \
        ./configure --prefix="${PREFIX}" && \
        make check && \
        make install && \
        rm -rf ${DIR}

RUN \
## libaribb24
        echo ">>> BUILD: libaribb24 <<" && \
        DIR=$(mktemp -d) && cd ${DIR} && \
        curl -sLO https://github.com/nkoriyama/aribb24/archive/v${LIBARIBB24_VERSION}.tar.gz && \
        echo ${LIBARIBB24_SHA256SUM} | sha256sum --check && \
        tar -xz --strip-components=1 -f v${LIBARIBB24_VERSION}.tar.gz && \
        autoreconf -fiv && \
        ./configure CFLAGS="-I${PREFIX}/include -fPIC" --prefix="${PREFIX}" && \
        make && \
        make install && \
        rm -rf ${DIR}

RUN  \
## ffmpeg https://ffmpeg.org/
        echo ">>> BUILD: ffmpeg <<" && \
        DIR=$(mktemp -d) && cd ${DIR} && \
        curl -sLO https://ffmpeg.org/releases/ffmpeg-${FFMPEG_VERSION}.tar.bz2 && \
        tar -jx --strip-components=1 -f ffmpeg-${FFMPEG_VERSION}.tar.bz2 && \
        ./configure --help && \
        ./configure \
        --arch=arm \
        --disable-debug \
        --disable-doc \
        --disable-ffplay \
        --enable-shared \
        --enable-avresample \
        --enable-libopencore-amrnb \
        --enable-libopencore-amrwb \
        --enable-gpl \
        --enable-libass \
        --enable-fontconfig \
        --enable-libfreetype \
        --enable-libvidstab \
        --enable-libfdk_aac \
        --enable-libmp3lame \
        --enable-libopenjpeg \
        --enable-libopus \
        --enable-libtheora \
        --enable-libvorbis \
        --enable-libvpx \
        --enable-libwebp \
        --enable-libxcb \
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
        --enable-libbluray \
        --enable-libzmq \
        --extra-libs=-ldl \
        --prefix="${PREFIX}" \
        --enable-libopenjpeg \
        --enable-libkvazaar \
        --enable-libaom \
        --extra-libs=-lpthread \
        --enable-libsrt \
        --enable-libaribb24 \
        --enable-zlib \
        --extra-cflags="-I${PREFIX}/include" \
        --extra-ldflags="-L${PREFIX}/lib" && \
        echo "#disable all tests">tests/Makefile && \
        make && \
        make install && \
        make tools/zmqsend && cp tools/zmqsend ${PREFIX}/bin/ && \
        make distclean && \
        hash -r && \
        cd tools && \
        make qt-faststart && \
        cp qt-faststart ${PREFIX}/bin/ && \
        rm -rf ${DIR}

RUN \
## setup ffmpeg lib64 libs
        echo ">>> SETUP: ffmpeg lib64 libs <<" && \
        ldd ${PREFIX}/bin/ffmpeg | grep opt/ffmpeg | cut -d ' ' -f 3 | xargs -i cp {} /usr/local/lib64/ && \
        for lib in /usr/local/lib64/*.so.*; do ln -s "${lib##*/}" "${lib%%.so.*}".so; done && \
        cp ${PREFIX}/bin/* /usr/local/bin/ && \
        cp -r ${PREFIX}/share/ffmpeg /usr/local/share/ && \
        LD_LIBRARY_PATH=/usr/local/lib64 ffmpeg -buildconf && \
        cp -r ${PREFIX}/include/libav* ${PREFIX}/include/libpostproc ${PREFIX}/include/libsw* /usr/local/include && \
        mkdir -p /usr/local/lib64/pkgconfig && \
        for pc in ${PREFIX}/lib/pkgconfig/libav*.pc ${PREFIX}/lib/pkgconfig/libpostproc.pc ${PREFIX}/lib/pkgconfig/libsw*.pc; do \
          sed "s:${PREFIX}:/usr/local:g" <"$pc" >/usr/local/lib64/pkgconfig/"${pc##*/}"; \
        done && \
        ldconfig -v && ffmpeg -buildconf

RUN \
## setup jre fallback fonts
        echo ">>> SETUP: jre fallback fonts <<" && \
        mkdir -p /usr/java/default/jre/lib/fonts/fallback && \
        ln -s /usr/share/fonts/cjkuni-ukai/ukai.ttc /usr/java/default/jre/lib/fonts/fallback && \
        ln -s /usr/share/fonts/cjkuni-uming/uming.ttc /usr/java/default/jre/lib/fonts/fallback && \
        cd /tmp/workdir && unzip msft-fonts.zip && cp msft-fonts/* /usr/java/default/jre/lib/fonts/fallback/ && \
        rm -fr /tmp/workdir/msft-fonts /tmp/workdir/msft-fonts.zip

RUN \
## clenaup
        echo ">>> CLEANUP <<" && \
        dnf clean all && rm -rf /var/lib/yum/*

ENV LD_LIBRARY_PATH=/usr/local/lib64:/usr/local/lib
