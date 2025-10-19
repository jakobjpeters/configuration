
FROM debian

ENV PATH="${PATH}:/root/.cargo/bin"

WORKDIR /root

COPY scripts scripts

RUN scripts/install.sh
RUN nu scripts/update.nu
# RUN scripts/install_niri.nu
RUN rm --recursive scripts

CMD ["nu"]
ENTRYPOINT ["nu", "--commands"]
