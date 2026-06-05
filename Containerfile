
FROM debian

ARG USER=container

ENV PATH="${PATH}:/home/${USER}/.cargo/bin"

RUN apt update
RUN apt install --yes sudo
RUN echo "${USER} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
RUN groupadd --gid 1000 ${USER}
RUN useradd --uid 1000 --gid ${USER} --create-home --shell /bin/bash ${USER}

WORKDIR /home/${USER}

USER ${USER}

# prevent cache invalidation from other scripts
COPY --chown=${USER} scripts/install.sh scripts/
RUN scripts/install.sh

ARG NAME

COPY --chown=${USER} scripts scripts
RUN nu scripts/install/$NAME.nu
RUN rm --recursive scripts

CMD ["nu"]
ENTRYPOINT ["nu", "--commands"]
