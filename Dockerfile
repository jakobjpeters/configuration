
# TODO: reproducibly install Rust
FROM rust

WORKDIR /root

# prevent cache invalidation from other scripts
COPY scripts/install_nu.sh scripts/
RUN scripts/install_nu.sh

ARG NAME

COPY scripts scripts
RUN nu scripts/install/$NAME.nu
RUN rm --recursive scripts

CMD ["nu"]
ENTRYPOINT ["nu", "--commands"]
