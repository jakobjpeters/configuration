
FROM debian:trixie

ENV PATH="/root/.cargo/bin:${PATH}"

COPY scripts scripts

RUN --mount=type=cache,target=/root/home/.cargo/registry scripts/install.sh && scripts/update.sh
RUN rm --recursive scripts

CMD nu
