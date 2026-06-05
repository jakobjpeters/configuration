
FROM debian

ARG HOME=/root

ENV PATH="${PATH}:${HOME}/.cargo/bin"

WORKDIR ${HOME}

# prevent cache invalidation from other scripts
COPY scripts/install.sh scripts/
RUN scripts/install.sh

ARG NAME

COPY scripts scripts
RUN nu scripts/install/$NAME.nu
RUN rm --recursive scripts

CMD ["nu"]
ENTRYPOINT ["nu", "--commands"]
