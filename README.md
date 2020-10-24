# OracleJDK Container

The goal of this project is to provide a base container image with support for `Oracle JDK`. While
Oracle itself already provides container images with JDK support (see [Github][oracle1] and 
[Docker Hub][oracle2]) those images are based on [Oracle Linux][oracle3]. This project covers 
additional OS distributions.

* [Debian][debian1] Buster (10) Slim
* [Ubuntu][ubuntu1] Focal (20.04)
* CentOS ...
* Alpine ...

> Due to license restrictions no image for this template is available on Docker Hub or any other 
> publicly available container registry. You will have to build the container image yourself and 
> then push it to your private registry.

# Build

To build the template please refer to the README of the respective distribution.

[oracle1]: https://github.com/oracle/docker-images/blob/master/OracleJava
[oracle2]: https://hub.docker.com/_/oracle-jdk?tab=description
[oracle3]: https://www.oracle.com/linux/
[debian1]: https://www.debian.org/
[ubuntu1]: https://ubuntu.com/
