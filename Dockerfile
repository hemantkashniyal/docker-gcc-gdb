FROM ubuntu:16.04
MAINTAINER Hemant Kashniyal <hemantkashniyal@gmail.com>
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    apt-get install -y gcc gdb && \
    apt-get install -y vim git

ARG INSTALL_LOCATION='/usr/local'
ARG SETUP_LOCATION='/tmp/setup'

RUN mkdir -p ${INSTALL_LOCATION}

# install protobuf
ARG PROTOBUF_REPO='https://github.com/google/protobuf.git'
ARG PROTOBUF_CHECKOUT='tags/v3.6.1'
ARG PROTOBUF_SETUP_PATH=${SETUP_LOCATION}'/PROTOBUF'
RUN apt-get install -y autoconf automake libtool curl make g++ unzip && \
    git clone ${PROTOBUF_REPO} ${PROTOBUF_SETUP_PATH} && \
    cd ${PROTOBUF_SETUP_PATH} && git checkout ${PROTOBUF_CHECKOUT} && git submodule update --init --recursive && \
    ./autogen.sh && \
    ./configure --prefix=${INSTALL_LOCATION} && \
    make && \
    make check && \
    make install && \
    ldconfig && \
    rm -rf ${PROTOBUF_SETUP_PATH}

# install g3log
ARG G3LOG_REPO='https://github.com/KjellKod/g3log.git'
ARG G3LOG_CHECKOUT='tags/1.3.2'
ARG G3LOG_SETUP_PATH=${SETUP_LOCATION}'/G3LOG'
RUN apt-get install -y autoconf automake libtool curl make g++ unzip && \
    git clone ${G3LOG_REPO} ${G3LOG_SETUP_PATH} && \
    cd ${G3LOG_SETUP_PATH} && git checkout ${G3LOG_CHECKOUT} && git submodule update --init --recursive && \
    cd 3rdParty/gtest && unzip -u -o gtest-1.7.0.zip && cd ../../ && \
    mkdir -p ./cmake_build && cd ./cmake_build && \
    cmake .. -DCMAKE_BUILD_TYPE=Release -DCPACK_PACKAGING_INSTALL_PREFIX=${INSTALL_LOCATION} && \
    make package && \
    make install && \
    ldconfig && \
    rm -rf ${G3LOG_SETUP_PATH}

# install zmq
ARG ZMQ_REPO='https://github.com/zeromq/libzmq'
ARG ZMQ_CHECKOUT='tags/v4.3.0'
ARG ZMQ_SETUP_PATH=${SETUP_LOCATION}'/ZMQ'
RUN apt-get install -y autoconf automake libtool curl make g++ unzip && \
    git clone ${ZMQ_REPO} ${ZMQ_SETUP_PATH} && \
    cd ${ZMQ_SETUP_PATH} && git checkout ${ZMQ_CHECKOUT} && git submodule update --init --recursive && \
    mkdir -p ./cmake_build && cd ./cmake_build && \
    cmake .. -DCMAKE_BUILD_TYPE=Release -DCPACK_PACKAGING_INSTALL_PREFIX=${INSTALL_LOCATION} && \
    make && \
    make install && \
    ldconfig && \
    rm -rf ${ZMQ_SETUP_PATH}

# install cppzmq
ARG CPPZMQ_REPO='https://github.com/zeromq/cppzmq'
ARG CPPZMQ_CHECKOUT='tags/v4.3.1'
ARG CPPZMQ_SETUP_PATH=${SETUP_LOCATION}'/CPPZMQ'
RUN apt-get install -y autoconf automake libtool curl make g++ unzip && \
    git clone ${CPPZMQ_REPO} ${CPPZMQ_SETUP_PATH} && \
    cd ${CPPZMQ_SETUP_PATH} && git checkout ${CPPZMQ_CHECKOUT} && git submodule update --init --recursive && \
    mkdir -p ./cmake_build && cd ./cmake_build && \
    cmake .. -DCMAKE_BUILD_TYPE=Release -DCPACK_PACKAGING_INSTALL_PREFIX=${INSTALL_LOCATION} && \
    make && \
    make install && \
    ldconfig && \
    rm -rf ${CPPZMQ_SETUP_PATH}

# install poco
ARG POCO_REPO='https://github.com/pocoproject/poco.git'
ARG POCO_CHECKOUT='tags/poco-1.9.0-release'
ARG POCO_SETUP_PATH=${SETUP_LOCATION}'/POCO'
RUN apt-get install -y libssl-dev && \
    git clone ${POCO_REPO} ${POCO_SETUP_PATH} && \
    cd ${POCO_SETUP_PATH} && git checkout ${POCO_CHECKOUT} && git submodule update --init --recursive && \
    mkdir -p ./cmake_build && cd ./cmake_build && \
    cmake .. -DCMAKE_INSTALL_PREFIX=${INSTALL_LOCATION} && \
    make && \
    make install && \
    ldconfig && \
    rm -rf ${POCO_SETUP_PATH}

#install opencv
ARG OPENCV_REPO='https://github.com/opencv/opencv.git'
ARG OPENCV_CHECKOUT='3.4'
ARG OPENCV_SETUP_PATH=${SETUP_LOCATION}'/OPENCV'
RUN apt-get install -y libssl-dev && \
    git clone ${OPENCV_REPO} ${OPENCV_SETUP_PATH} && \
    cd ${OPENCV_SETUP_PATH} && git checkout ${OPENCV_CHECKOUT} && git submodule update --init --recursive && \
    mkdir -p ./cmake_build && cd ./cmake_build && \
    cmake .. -DCMAKE_INSTALL_PREFIX=${INSTALL_LOCATION} && \
    make && \
    make install && \
    ldconfig && \
    rm -rf ${OPENCV_SETUP_PATH}
