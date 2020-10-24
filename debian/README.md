# OracleJDK Container

This container image is based on `Debian Buster Slim` and has support for `Oracle JDK`. 

## Build

To build the image perform the steps outlined below.

1. Download an Oracle JDK archive ([jdk8](jdk8), [jdk11](jdk11), [jdk15](jdk15)) in the `tar.gz` 
   format and store it next to the Dockerfile.
1. Execute the following command (update/remove the arguments accordingly).
   > Windows users will have to use a Linux VM to run the command.
   ```
   JAVA_VERSION=11.0.8 && \
   docker build \
     --build-arg JAVA_ARCHIVE=./jdk-binary.tar.gz \
     --build-arg JAVA_HOME=/opt/jdk \
     --build-arg JAVA_VERSION=${JAVA_VERSION} \
     --build-arg PACKAGES="vi less" \
     --build-arg TZ="Europe/Zurich" \
     --label org.label-schema.name="Debian Buster Slim with Oracle JDK ${JAVA_VERSION}" \
     --label org.label-schema.license="Apache 2.0" \
     --label org.label-schema.vendor="Company Inc" \
     --label org.label-schema.vcs-url="https://git.company.com/docker-oraclejdk" \
     --label org.label-schema.vcs-ref=$(git rev-parse --short HEAD) \
     --label org.label-schema.build-date=$(date -u +'%Y-%m-%d') \
     --tag namespace/oraclejdk:${JAVA_VERSION}-debian10 \
     . && \
     \
     docker rmi $(docker images -q -f dangling=true) || true
   ```

   The following build parameter are available for this template.

   Name         | Default Value | Description
   ---          | ---           | ---
   JAVA_HOME    | `/opt/jdk`    | The home location of the JDK installation.
   JAVA_VERSION | 11            | Value is used to tag and label the image accordingly.
   JAVA_ARCHIVE |               | The path to the locally stored JDK archive.
   PACKAGES     |               | A space separated list of Debian packages to install.
   TZ           | Europe/Zurich | Defines the timezone in the container.
   
   > Please note that the Debian image used for this image is very basic and lacks lots of common
   > tools (e.g. `nano`, `vi(m)`, `less`, ...). If needed add them via the `PACKAGES` argument.
   > Packages will be installed with the option `--no-install-recommends`.


[jdk8]:  https://www.oracle.com/java/technologies/javase/javase-jdk8-downloads.html
[jdk11]: https://www.oracle.com/java/technologies/javase-jdk11-downloads.html
[jdk15]: https://www.oracle.com/java/technologies/javase-jdk15-downloads.html
