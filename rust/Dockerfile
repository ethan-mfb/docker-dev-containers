ARG RUST_VERSION=1.86.0

FROM ubuntu:24.04 
ARG DEBIAN_FRONTEND=noninteractive
ARG RUST_VERSION
RUN yes | unminimize
RUN apt-get update && apt-get install -y git curl ssh sudo locales build-essential libssl-dev pkg-config 
# set the locale
RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && \
    locale-gen
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8
# setup dev user
RUN useradd -ms /bin/bash -u 1002 -G sudo devuser
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
WORKDIR /home/devuser
ENV TERM="xterm-256color"
ADD https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash .git-completion.bash
ADD https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh .git-prompt.sh
COPY dotfiles/bashrc .bashrc
COPY .gitconfig .gitconfig
RUN chown -R devuser /home/devuser
USER devuser
# install Rust using rustup
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y --default-toolchain ${RUST_VERSION}
ENV PATH="/home/devuser/.cargo/bin:${PATH}"
# add public keys for well known repos
RUN mkdir -p -m 0700 ~/.ssh
RUN ssh-keyscan github.com >> ~/.ssh/known_hosts
ENTRYPOINT ["bash"]
