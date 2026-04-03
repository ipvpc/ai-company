FROM node:current-bullseye

# Node 25+ images no longer ship corepack; npm global install puts pnpm in /usr/local/bin for all users.
RUN npm install -g pnpm@9.15.4

RUN groupadd --gid 10001 paperclip \
  && useradd --create-home --shell /bin/bash --uid 10001 --gid 10001 paperclip \
  && mkdir -p /paperclip /home/paperclip /home/paperclip/.local/share/pnpm \
  && chown -R paperclip:paperclip /paperclip /home/paperclip

USER paperclip

WORKDIR /home/paperclip

ENV PNPM_HOME=/home/paperclip/.local/share/pnpm
ENV PATH=$PNPM_HOME:$PATH

RUN pnpm config set global-bin-dir "$PNPM_HOME" \
  && pnpm install -g paperclipai
RUN npx paperclipai -y onboard --yes
