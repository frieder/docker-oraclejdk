FROM debian:buster-slim AS builder

WORKDIR /tmp/jdk

ARG JAVA_ARCHIVE
COPY ${JAVA_ARCHIVE} ./oraclejdk.tar.gz

RUN tar -xf oraclejdk.tar.gz --strip 1 && \
    rm oraclejdk.tar.gz && \
    rm src.zip || true

####################################################################################################

FROM debian:buster-slim

ARG JAVA_HOME=/opt/jdk
ARG JAVA_VERSION=11
ARG PACKAGES
ARG TZ=Europe/Zurich

LABEL org.label-schema.schema-version=1.0

ENV JAVA_HOME=${JAVA_HOME}
ENV PATH ${JAVA_HOME}/bin:${PATH}

COPY --from=builder /tmp/jdk ${JAVA_HOME}

RUN apt update && \
    DEBIAN_FRONTEND=noninteractive apt full-upgrade -y --no-install-recommends && \
    DEBIAN_FRONTEND=noninteractive apt autoremove -y && \
    \
    if [ ! "x$PACKAGES" = "x" ]; then \
        DEBIAN_FRONTEND=noninteractive apt install -y --no-install-recommends ${PACKAGES} ; \
    fi; \
    \
    if [ ! "x${TZ}" = "x" ]; then ln -fs /usr/share/zoneinfo/${TZ} /etc/localtime ; fi && \
    if [ ! "x${TZ}" = "x" ]; then dpkg-reconfigure --frontend noninteractive tzdata ; fi && \
    \
    rm -rf /var/lib/apt/lists/* && \
    \
    for bin in ${JAVA_HOME}/bin/*; do \
        base=$(basename ${bin}); \
        update-alternatives --install /usr/bin/${base} ${base} ${bin} 1000; \
    done; \
    \
    java -Xshare:dump
