FROM python:3-trixie

RUN apt-get update -qy && apt-get dist-upgrade -qy && \
    apt-get install -qy --no-install-recommends curl \
    ca-certificates \
    wget \
    neovim \
    ripgrep \
    build-essential \
    kubectl \
    unzip && \
    apt-get -qqy autoremove && apt-get -qqy autoclean

# install doctl (DigitalOcean CLI) - required as a kubectl credential plugin
ARG DOCTL_VERSION=1.147.0
RUN curl -fsSL "https://github.com/digitalocean/doctl/releases/download/v${DOCTL_VERSION}/doctl-${DOCTL_VERSION}-linux-amd64.tar.gz" \
    | tar -xz -C /usr/local/bin doctl && \
    chmod +x /usr/local/bin/doctl

# install node, see https://nodesource.com/products/distributions
RUN curl -fsSL https://deb.nodesource.com/setup_24.x | bash -
RUN apt-get install -qy nodejs
# and install pi.dev
RUN npm install -g npm@12.0.2 && npm install -g --ignore-scripts --min-release-age=0 @earendil-works/pi-coding-agent

# Run non privileged
RUN groupadd --gid 1000 fatz
RUN useradd --create-home --home-dir /home/fatz --shell /bin/bash \
    --gid 1000 --uid 1000 fatz

USER fatz

# install hunk
RUN curl -fsSL https://hunk.dev/install.sh | sh
# PATH
ENV PATH="$PATH:/home/fatz/.local/bin:/home/fatz/.hunk/bin"



WORKDIR /workspace

ENTRYPOINT ["pi"]

