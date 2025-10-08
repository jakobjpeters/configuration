
FROM debian:trixie

ENV PATH="/root/.cargo/bin:${PATH}"

WORKDIR /root/code/projects/configuration

COPY . .

RUN scripts/install.sh
# RUN nu scripts/update.nu

CMD ["nu"]
