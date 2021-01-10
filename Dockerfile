# Dockerfile for Miniflux
#
# Copyright 2020, Ankit R Gadiya
# BSD 3-Clause License
FROM alpine:latest
LABEL MAINTAINER="Ankit R Gadiya git@argp.in"

ENV MINIFLUX_VERSION="2.0.27"

RUN apk --update --no-cache add ca-certificates tzdata \
  && wget \
  -O "/usr/local/bin/miniflux" \
  "https://github.com/miniflux/v2/releases/download/${MINIFLUX_VERSION}/miniflux-linux-amd64" \
  && chmod +x "/usr/local/bin/miniflux"

COPY ./entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
