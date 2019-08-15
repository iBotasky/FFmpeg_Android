#!/bin/zsh
export TMPDIR=/Users/moore/Documents/ffmpeg/ffmpeg-3.4.2/temp
NDK=/Users/moore/Library/Android/sdk/ndk-bundle
SYSROOT=$NDK/platforms/android-21/arch-arm/
TOOLCHAIN=/Users/moore/Library/Android/sdk/ndk-bundle/toolchains/arm-linux-androideabi-4.9/prebuilt/darwin-x86_64
CPU=arm
PREFIX=/Users/moore/Documents/ffmpeg/ffmpeg-3.4.2/output
ADDI_CFLAGS="-marm"
function build_one
{
    ./configure \
        --prefix=$PREFIX \
        --enable-shared \
        --disable-static \
        --disable-doc \
        --disable-ffmpeg \
        --disable-ffplay \
        --disable-ffprobe \
        --disable-ffserver \
        --disable-doc \
        --disable-symver \
        --enable-small \
        --enable-jni\
        --enable-mediacodec\
        --enable-decoder=h264_mediacodec\
        --enable-hwaccel=h264_mediacodec\
        --cross-prefix=$TOOLCHAIN/bin/arm-linux-androideabi- \
        --target-os=android \
        --arch=arm \
        --enable-cross-compile \
        --sysroot=$SYSROOT \
        --extra-cflags="-Os -fpic $ADDI_CFLAGS" \
        --extra-ldflags="$ADDI_LDFLAGS" \
        $ADDITIONAL_CONFIGURE_FLAG
    make clean
    make
    make install
}
build_one
cd ../
