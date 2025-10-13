
FROM debian:trixie

ENV PATH="/root/.cargo/bin:${PATH}"

COPY scripts scripts

RUN scripts/install.sh
RUN scripts/install.nu
RUN nu scripts/update.nu
# RUN scripts/install_niri.nu
RUN rm --recursive scripts

CMD ["nu"]
