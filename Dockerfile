# syntax=docker/dockerfile:1
FROM debian:bookworm-slim

LABEL org.opencontainers.image.authors="Mitsuru Shimamura <smbd.jp@gmail.com>"

RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
    tini ca-certificates tigervnc-standalone-server tigervnc-tools novnc websockify \
    firefox-esr fonts-noto-cjk \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

ENV LANGUAGE=ja_JP.UTF-8
ENV LANG=ja_JP.UTF-8

RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

COPY --chmod=0700 dot.vnc /root/.vnc
COPY dot.mozilla /root/.mozilla
COPY --chmod=0755 entrypoint.sh /usr/local/bin/

EXPOSE 80

ENTRYPOINT ["/usr/bin/tini", "--"]
CMD ["/usr/local/bin/entrypoint.sh"]
