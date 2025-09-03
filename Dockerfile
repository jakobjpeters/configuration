
FROM debian:trixie

WORKDIR /configuration

COPY . .

RUN scripts/install.sh
