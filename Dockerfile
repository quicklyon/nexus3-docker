ARG VERSION=latest

FROM hub.qucheng.com/app/nexus3:${VERSION}

LABEL maintainer "ysicing"

ENV OS_ARCH="amd64" \
    OS_NAME="debian-11" \
    HOME_PAGE="https://github.com/sonatype/docker-nexus3"

ENV TZ=Asia/Shanghai \
    DEBIAN_FRONTEND=noninteractive

ARG IS_CHINA="true"
ENV MIRROR=${IS_CHINA}

ENV APP_VER=${VERSION}
ENV EASYSOFT_APP_NAME="Nexus3 $APP_VER"

EXPOSE 8081

USER root

COPY rootfs /
COPY prebuildfs /

# Persistence directory
VOLUME [ "/nexus-data"]

USER nexus

CMD ["/usr/bin/entrypoint.sh"]
