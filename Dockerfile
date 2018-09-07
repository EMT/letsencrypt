FROM alpine:latest

MAINTAINER Fieldwork

RUN apk add --no-cache \
        python \
        py-setuptools \
        py2-pip \
        openssl \
        ca-certificates \
        git \
    && apk add --no-cache --virtual build_deps \
        musl-dev \
        openssl-dev \
        libffi-dev \
        gcc \
        python-dev \
    && pip install git+https://github.com/zenhack/simp_le/ \
    && mkdir /certs \
    && apk --purge del build_deps \
    && rm -rf /root/.cache

COPY getcert.sh /
RUN chmod +x /getcert.sh
CMD ["/getcert.sh"]
