# OracleJDK Container

This container image is based on `Debian Slim` and has support for `Oracle JDK`. The goal is to get 
a small container image with a full-fledged Linux distribution and Oracle JDK support.

> Due to license restrictions no image for this template is available on Docker Hub or any other
> publicly available container registry. You will have to build the container image yourself and
> then push it to your private registry.

## Build

To build the image perform the steps outlined below.

1. Update `Dockerfile` to your needs.
   1. It is possible to overwrite the `LABEL` values when building the image. <br/>
      ```
      --label org.label-schema.name="Debian Slim with Oracle JDK 11"
      --label org.label-schema.license="Apache 2.0"
      --label org.label-schema.vendor="Company Inc"
      --label org.label-schema.vcs-url="https://git.company.com/docker-oraclejdk"
      ```
2. Download an Oracle JDK archive ([jdk8](jdk8), [jdk11](jdk11), [jdk15](jdk15)) in the `tar.gz` 
   format and store it to a local path.
3. Execute the following command (update the arguments accordingly).
   > Windows users will have to use a bash emulator (e. g. Git Bash) to run the command.
   ```
   JAVA_VERSION=11.0.8 \
   docker build \
    --build-arg JAVA_VERSION=${JAVA_VERSION} \
    --build-arg JAVA_ARCHIVE=./path/to/local/jdk-binary.tar.gz \
    --label org.label-schema.build-date=$(date -u +'%Y-%m-%d') \
    --label org.label-schema.vcs-ref=$(git rev-parse --short HEAD) \
    --tag frieder/oraclejdk:${JAVA_VERSION} \
    .
   ```

   The following build parameter are available for this template.

   Name         | Default Value | Description
   ---          | ---           | ---
   JAVA_VERSION | 11            | Value is used to tag and label the image accordingly
   JAVA_ARCHIVE |               | The path to the locally stored JDK archive
   PACKAGES     |               | A space separated list of Debian packages to install.
   TZ           | Europe/Zurich | Defines the timezone in the container
   
   > Please note that the Debian image used for this image is very basic and lacks lots of common
   > tools (e. g. `nano`, `vi(m)`, `less`, ...). If needed add them via the `PACKAGES` argument.

# Follow-up Tasks

Once the container image is created one usually wants to push it to a local registry. Following is
a list of steps to perform.

1. Log into your private registry <br/>
   `docker login docker.company.com`
2. Tag the image accordingly <br/>
   `docker tag frieder/oraclejdk:11.0.8 docker.company.com/frieder/oraclejdk:11.0.8`
3. Push the image to the registry <br/>
   `docker push docker.company.com/frieder/oraclejdk:11.0.8`
4. Log out from the registry <br/>
   `docker logout`
5. Clean up local image <br/>
   `docker rmi frieder/oraclejdk:11.0.8`
6. Remove dangling images <br/>
   `docker rmi $(docker images -q -f dangling=true) || true`


[jdk8]:  https://www.oracle.com/java/technologies/javase/javase-jdk8-downloads.html
[jdk11]: https://www.oracle.com/java/technologies/javase-jdk11-downloads.html
[jdk15]: https://www.oracle.com/java/technologies/javase-jdk15-downloads.html
