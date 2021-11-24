ARG  DOCKER_BASE_IMAGE=kittychain/build_base:1.0-go1.13.3-solc0.4.24
FROM ${DOCKER_BASE_IMAGE}
MAINTAINER Jesse Lee jesse.lee@groundx.xyz

ENV PKG_DIR /kittychain-docker-pkg
ENV SRC_DIR /go/src/github.com/kittychain/kittychain

ARG KITTYCHAIN_RACE_DETECT=0
ENV KITTYCHAIN_RACE_DETECT=$KITTYCHAIN_RACE_DETECT

RUN mkdir -p $PKG_DIR/bin
RUN mkdir -p $PKG_DIR/conf

ADD . $SRC_DIR
RUN cd $SRC_DIR && make all

RUN cp $SRC_DIR/build/bin/* /usr/bin/

# packaging
RUN cp $SRC_DIR/build/bin/* $PKG_DIR/bin/

RUN cp $SRC_DIR/build/packaging/linux/bin/* $PKG_DIR/bin/

RUN cp $SRC_DIR/build/packaging/linux/conf/* $PKG_DIR/conf/

EXPOSE 8551 8552 32323 61001 32323/udp
