#!/bin/bash
NDK=/Users/botaskywells/Downloads/android-ndk-r15c
# SYSROOT=$NDK/platforms/android-19/arch-arm/
# TOOLCHAIN=$NDK/toolchains/arm-linux-androideabi-4.9/prebuilt/darwin-x86_64
# PREFIX=/Users/botaskywells/Downloads/x264/armv7-a
# function build_one
# {
#     ./configure \
#     --prefix=$PREFIX \
#     --enable-shared \
#     --enable-pic \
#     --host=arm-linux \
#     --cross-prefix=$TOOLCHAIN/bin/arm-linux-androideabi- \
#     --sysroot=$SYSROOT \
    
#     make
#     make install
# }

# build_one



configure()
{
    CPU=$1
    PREFIX=./android/$CPU
    HOST=""
    CROSS_PREFIX=""
    SYSROOT=""
    if [ "$CPU" == "armv7-a" ]
    then
        HOST=arm-linux
        SYSROOT=$NDK/platforms/android-21/arch-arm/
        CROSS_PREFIX=$NDK/toolchains/arm-linux-androideabi-4.9/prebuilt/darwin-x86_64/bin/arm-linux-androideabi-
    else
        HOST=aarch64-linux-android
        SYSROOT=$NDK/platforms/android-21/arch-arm64/
        CROSS_PREFIX=$NDK/toolchains/aarch64-linux-android-4.9/prebuilt/darwin-x86_64/bin/aarch64-linux-android-
    fi
    ./configure \
    --prefix=$PREFIX \
    --host=$HOST \
    --enable-pic \
    --enable-shared \
    --enable-static \
    --enalbe-neon \
    --cross-prefix=$CROSS_PREFIX \
    --sysroot=$SYSROOT 
}

build()
{
    make clean
    cpu=$1
    echo "build $cpu"

    configure $cpu
    #-j<CPU核心数>
    make -j4
    make install
}

# build armv7-a
build armv8-a