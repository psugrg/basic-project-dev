FROM ubuntu:24.04 AS base

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    curl \
  && rm -rf /var/lib/apt/lists/*

FROM base AS development

# Ubuntu 24.04 has a default user `ubuntu` that we want to remove
RUN userdel -r ubuntu

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    ca-certificates \
    git \
    openssh-client \
    sudo \
  && rm -rf /var/lib/apt/lists/* \
  && useradd -m -s /bin/bash devuser \
  && echo "devuser ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/devuser \
  && chmod 0440 /etc/sudoers.d/devuser

WORKDIR /workspaces/basic-project-dev

FROM base AS production

WORKDIR /app

COPY src/ /app/
RUN chmod +x /app/example.sh

CMD ["/app/example.sh"]
