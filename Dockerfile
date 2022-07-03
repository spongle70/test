# 
#
ARG IMG_VERSION alpine:3.12.0
FROM ${IMG_VERSION}
#
#
# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE
ARG VCS_REF
ARG VCS_URL
ARG VERSION

ARG NAS_USER qwe

LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="zzbase" \
      org.label-schema.description="zzBase Alpine Images" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.version=$VERSION \
      org.label-schema.schema-version="1.0"
#
#      
ENV APP_USER='myapps' \
    APP_GROUP='myapps' \
    APP_UID='1001' \
    APP_GID='1001' \
    APP_VERSION=master

ENV MYHOST $MYHOST \
    SSH_PASSWORD "$SSH_PASSWORD" \
    SSH_KEY "$SSH_KEY" 

ENV DEBIAN_FRONTEND='noninteractive' \
    LANG='en_US.UTF-8' \
    LANGUAGE='en_US.UTF-8' \
    TERM='xterm' \
    TZ='Etc/UTC' \
    NAS_GROUP='donkey' \
    NAS_UID='1003' \
    NAS_GID='1003'

# add a non-root user and group with no password
RUN set -ex && \
    addgroup \
    -S \
    -g ${APP_GID} ${APP_GROUP} && \
    adduser \
    -D \
    -g "${APP_USER}Service" \
    -h /var/lib/${APP_USER} \
    -s /bin/false \
    -u ${APP_UID} \
    -G ${APP_GROUP} ${APP_USER}

# add a non-root user and group with no password
RUN set -ex && \
    addgroup \
    -S \
    -g ${NAS_GID} ${NAS_GROUP} && \
    adduser \
    -D \
    -g "${NAS_USER}Service" \
    -h /var/lib/${NAS_USER} \
    -s /bin/false \
    -u ${NAS_UID} \
    -G ${NAS_GROUP} ${NAS_USER}

# clean any packages
RUN set -ex && rm -rf /tmp/* /var/cache/apk/*  /var/lib/apt/lists/* /var/tmp/*
#
#
# Install dependencies
#RUN set -ex && \
#    apk --no-cache --update add \
#        git
