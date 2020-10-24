FROM debian:buster-slim AS builder

WORKDIR /tmp/jdk

ARG JAVA_ARCHIVE
COPY ${JAVA_ARCHIVE} ./oraclejdk.tar.gz

RUN tar -xf oraclejdk.tar.gz --strip 1 && \
    rm oraclejdk.tar.gz && \
    rm src.zip || true

####################################################################################################

FROM debian:buster-slim

ARG JAVA_VERSION=11
ARG PACKAGES
ARG TZ=Europe/Zurich

LABEL org.label-schema.schema-version=1.0 \
      org.label-schema.name="OracleJDK ${JAVA_VERSION} base image" \
      org.label-schema.license="Apache 2.0" \
      org.label-schema.vendor="Frieder Heugel" \
      org.label-schema.vcs-url="https://github.com/frieder/docker-oraclejdk"

WORKDIR /opt/jdk

COPY --from=builder /tmp/jdk ./

RUN update-alternatives --install /usr/bin/jar jar /opt/jdk/bin/jar 100 && \
    update-alternatives --install /usr/bin/java java /opt/jdk/bin/java 100 && \
    update-alternatives --install /usr/bin/javac javac /opt/jdk/bin/javac 100 && \
    update-alternatives --install /usr/bin/javadoc javadoc /opt/jdk/bin/javadoc 100 && \
    update-alternatives --install /usr/bin/jcmd jcmd /opt/jdk/bin/jcmd 100 && \
    update-alternatives --install /usr/bin/jmap jmap /opt/jdk/bin/jmap 100 && \
    update-alternatives --install /usr/bin/jstack jstack /opt/jdk/bin/jstack 100 && \
    update-alternatives --install /usr/bin/jstat jstat /opt/jdk/bin/jstat 100 && \
    \
    apt update && \
    DEBIAN_FRONTEND=noninteractive apt full-upgrade -y --no-install-recommends && \
    DEBIAN_FRONTEND=noninteractive apt autoremove -y && \
    \
    if [ ! "x$PACKAGES" = "x" ]; then \
        DEBIAN_FRONTEND=noninteractive apt install -y --no-install-recommends ${PACKAGES} ; fi && \
    \
    if [ ! "x${TZ}" = "x" ]; then ln -fs /usr/share/zoneinfo/${TZ} /etc/localtime ; fi && \
    if [ ! "x${TZ}" = "x" ]; then dpkg-reconfigure --frontend noninteractive tzdata ; fi && \
    \
    rm -rf /var/lib/apt/lists/*
