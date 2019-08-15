#!/bin/zsh
export TMPDIR=/Users/botaskywells/Downloads/ffmpegSource/temp
NDK=/Users/botaskywells/Downloads/android-ndk-r15c
# SYSROOT=$NDK/platforms/android-21/arch-arm64
# TOOLCHAIN=$NDK/toolchains/aarch64-linux-android-4.9/prebuilt/darwin-x86_64
# CPU=armv8-a
# PREFIX=/Users/botaskywells/Downloads/ffmpeg/android
# ADDI_CFLAGS="-marm"
# X264_INCLUDE=/Users/botaskywells/Downloads/ffmpegSource/ffmpeg-3.3.4/x264/include
# X264_LIB=/Users/botaskywells/Downloads/ffmpegSource/ffmpeg-3.3.4/x264/lib

XPATH=/Users/botaskywells/Downloads
configure()
{
    CPU=$1
    PREFIX=/Users/botaskywells/Downloads/ffmpeg_build/$CPU
    HOST=""
    CROSS_PREFIX=""
    SYSROOT=""
    ARCH=""
    X264_INCLUDE=""
    X264_LIB=""
    ADDI_CFLAGS=""

    if [[ "$CPU" == "armv7-a" ]] 
    then
        echo "build armv7-a"
        HOST=arm-linux
        SYSROOT=$NDK/platforms/android-26/arch-arm/
        CROSS_PREFIX=$NDK/toolchains/arm-linux-androideabi-4.9/prebuilt/darwin-x86_64/bin/arm-linux-androideabi-
        ARCH=arm
        X264_INCLUDE=$XPATH/armv7-a/include
        X264_LIB=$XPATH/armv7-a/lib
        ADDI_CFLAGS="-marm -march=$CPU"
    else
        echo "build armv8-a"
        HOST=aarch64-linux-android
        SYSROOT=$NDK/platforms/android-26/arch-arm64/
        CROSS_PREFIX=$NDK/toolchains/aarch64-linux-android-4.9/prebuilt/darwin-x86_64/bin/aarch64-linux-android-
        ARCH=aarch64
        X264_INCLUDE=$XPATH/armv8-a/include
        X264_LIB=$XPATH/armv8-a/lib
        ADDI_CFLAGS="-marm -march=$CPU"
    fi

    ./configure \
        --prefix=$PREFIX \
        --enable-shared \
        --cpu=$CPU \
        --extra-cflags="-I$X264_INCLUDE" \
        --extra-ldflags="-L$X264_LIB" \
        --disable-static \
        --disable-doc \
        --disable-ffmpeg \
        --disable-ffplay \
        --disable-ffprobe \
        --disable-ffserver \
        --disable-symver \
        --enable-small \
        --enable-jni \
        --enable-mediacodec \
        --enable-decoder=h264_mediacodec \
        --enable-hwaccel=h264_mediacodec \
        --enable-asm \
        --enable-neon \
        --enable-yasm \
        --disable-encoders \
        --enable-gpl \
        --enable-libx264 \
        --enable-encoder=libx264 \
        --enable-encoder=aac \
        --enable-encoder=mpeg4 \
        --enable-encoder=mjpeg \
        --enable-encoder=png \
        --cross-prefix=$CROSS_PREFIX \
        --target-os=android \
        --arch=$ARCH \
        --enable-cross-compile \
        --sysroot=$SYSROOT \
        $ADDITIONAL_CONFIGURE_FLAG
}


build()
{
    make clean
    cpu=$1

    configure $cpu
    make 
    make install
}

build armv8-a


        # --prefix=$PREFIX \
        # --enable-shared \
        # --cpu=$CPU \
        # --disable-static \
        # --disable-doc \
        # --disable-ffmpeg \
        # --disable-ffplay \
        # --disable-ffprobe \
        # --disable-ffserver \
        # --disable-doc \
        # --disable-symver \
        # --enable-small \
        # --enable-jni \
        # --enable-mediacodec \
        # --enable-decoder=h264_mediacodec \
        # --enable-hwaccel=h264_mediacodec \
        # --cross-prefix=$CROSS_PREFIX \
        # --target-os=android \
        # --arch=$ARCH \
        # --enable-cross-compile \
        # --sysroot=$SYSROOT \
        # --extra-cflags="-Os -fpic $ADDI_CFLAGS" \
        # --extra-ldflags="$ADDI_LDFLAGS" \
        # $ADDITIONAL_CONFIGURE_FLAG