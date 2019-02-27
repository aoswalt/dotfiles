FROM ubuntu

RUN apt-get update

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get install -y \
      git \
      zsh \
      gcc \
      build-essential \
      libssl-dev \
      zlib1g-dev \
      libbz2-dev \
      libreadline-dev \
      libsqlite3-dev \
      wget \
      curl \
      llvm \
      libncurses5-dev \
      xz-utils \
      tk-dev \
      libxml2-dev \
      libxmlsec1-dev \
      libffi-dev \
      liblzma-dev

WORKDIR /root/dotfiles

COPY . .
