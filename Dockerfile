
FROM debian:trixie

ENV PATH="/root/.cargo/bin:${PATH}"

WORKDIR /root

COPY scripts scripts

RUN scripts/install.sh
RUN nu scripts/update.nu
RUN rm --recursive scripts

CMD ["nu"]
