FROM ubuntu:22.04 AS development

ARG USERNAME=devuser
ARG USER_UID=1000
ARG USER_GID=1000

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    git \
    openssh-client \
    sudo \
  && rm -rf /var/lib/apt/lists/*

RUN groupadd --gid ${USER_GID} ${USERNAME} \
  && useradd --uid ${USER_UID} --gid ${USER_GID} -m ${USERNAME} \
  && mkdir -p /home/${USERNAME}/.config/git \
  && chown -R ${USERNAME}:${USERNAME} /home/${USERNAME}/.config \
  && echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/${USERNAME} \
  && chmod 0440 /etc/sudoers.d/${USERNAME}

WORKDIR /workspaces/basic-project-dev

FROM ubuntu:22.04 AS production

WORKDIR /app

COPY src/ /app/
RUN chmod +x /app/example.sh

CMD ["/app/example.sh"]
