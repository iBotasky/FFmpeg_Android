#!/bin/zsh
export TMPDIR=/Users/botaskywells/Downloads/ffmpegSource/temp
NDK=/Users/botaskywells/Downloads/android-ndk-r15c
HOST=aarch64-linux-android
SYSROOT=$NDK/platforms/android-21/arch-arm64/
CROSS_PREFIX=$NDK/toolchains/aarch64-linux-android-4.9/prebuilt/darwin-x86_64/bin/aarch64-linux-android-
ARCH=aarch64
ADDI_CFLAGS="-marm -march=arm64"
CPU=arm64-v8a
PREFIX=/Users/botaskywells/Downloads/ffmpeg_build/arm64
CC=$NDK/toolchains/aarch64-linux-android-4.9/prebuilt/darwin-x86_64/bin/aarch64-linux-android-gcc
NM=$NDK/toolchains/aarch64-linux-android-4.9/prebuilt/darwin-x86_64/bin/aarch64-linux-android-nm
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
        --enable-jni \
        --cc=$CC \
        --nm=$NM \
        --enable-mediacodec \
        --enable-decoder=h264_mediacodec \
        --enable-hwaccel=h264_mediacodec \
        --cross-prefix=$CROSS_PREFIX \
        --target-os=android \
        --arch=arm64 \
        --enable-cross-compile \
        --sysroot=$SYSROOT \
        $ADDITIONAL_CONFIGURE_FLAG
    make clean
    make
    make install
}
build_one
cd ../
