FROM certbot/certbot:v0.30.0

MAINTAINER Yves Blusseau <90z7oey02@sneakemail.com> (@blusseau)

ENV DEBUG=false              \
	DOCKER_GEN_VERSION=0.7.3 \
	DOCKER_HOST=unix:///var/run/docker.sock

RUN apk --update add bash curl ca-certificates procps jq tar git && \
	curl -L -O https://github.com/jwilder/docker-gen/releases/download/$DOCKER_GEN_VERSION/docker-gen-linux-amd64-$DOCKER_GEN_VERSION.tar.gz && \
	tar -C /usr/local/bin -xvzf docker-gen-linux-amd64-$DOCKER_GEN_VERSION.tar.gz && \
	rm -f docker-gen-linux-amd64-$DOCKER_GEN_VERSION.tar.gz && \
	apk del tar && \
	rm -rf /var/cache/apk/*

RUN git clone --single-branch --branch v0.30.0 https://github.com/certbot/certbot certbot-src \
 && pip install --no-cache-dir --editable certbot-src/certbot-dns-ovh

WORKDIR /app

ENTRYPOINT ["/bin/bash", "/app/entrypoint.sh" ]
CMD ["/bin/bash", "/app/start.sh" ]

COPY /app/ /app/
