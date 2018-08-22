FROM lsiobase/alpine:3.8

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="alex-phillips"

RUN \
 echo "**** install build packages ****" && \
 apk add --no-cache \
	nodejs \
	yarn && \
 apk add --no-cache --virtual=build-dependencies \
 	git \
	npm && \
 echo "**** install haste-server ****" && \
 git clone https://github.com/seejohnrun/haste-server.git /app/haste-server && \
 cd /app/haste-server && \
 /usr/bin/npm install && \
 echo "**** cleanup ****" && \
 apk del --purge \
	build-dependencies && \
 rm -rf \
	/root/.cache \
	/tmp/*

# copy local files
COPY root/ /

# ports and volumes
EXPOSE 8000
VOLUME /config
