FROM debian:bullseye

RUN apt-get -y update && apt-get -y install --no-install-recommends --no-install-suggests git apt-utils build-essential ca-certificates python3 python3-pip curl udev npm libnss3 libatk-bridge2.0-0 yarn cups libdrm2 libgtk-3-dev libnotify-dev libasound2 libcap-dev libudev-dev udev

ENV NVM_DIR /nvm
ENV NODE_VERSION v22.9.0
ENV NODE_ENV production
ENV NODE_PATH $NVM_DIR/$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/$NODE_VERSION/bin:$PATH

RUN git clone https://github.com/nvm-sh/nvm.git "$NVM_DIR" \
  && cd "$NVM_DIR" \
  && git checkout v0.40.1 \
  && . "$NVM_DIR/nvm.sh" \
  && nvm install "$NODE_VERSION" \
  && nvm alias default "$NODE_VERSION" \
  && nvm use --delete-prefix default

RUN node --version
RUN npm install -g npm@10.8.3
RUN npm install -g yarn@1.22.22

RUN useradd -u 1234 -m builduser

RUN mkdir /gsender

ENV NODE_OPTIONS --max-old-space-size=10000

COPY run.sh /run.sh

USER builduser
ENTRYPOINT /run.sh
