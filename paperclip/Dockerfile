FROM node:current-bullseye

# Node 25+ images no longer ship corepack; npm global install puts pnpm in /usr/local/bin for all users.
RUN npm install -g pnpm@9.15.4
RUN npm install --global --omit=dev @anthropic-ai/claude-code@latest @openai/codex@latest opencode-ai 

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

  ENV NODE_ENV=production \
  HOME=/home/paperclip \
  HOST=0.0.0.0 \
  PORT=3100 \
  SERVE_UI=true \
  PAPERCLIP_HOME=/home/paperclip \
  PAPERCLIP_INSTANCE_ID=default \
  USER_UID=${USER_UID} \
  USER_GID=${USER_GID} \
  PAPERCLIP_CONFIG=/paperclip/instances/default/config.json \
  PAPERCLIP_DEPLOYMENT_MODE=authenticated \
  PAPERCLIP_DEPLOYMENT_EXPOSURE=private \
  OPENCODE_ALLOW_ALL_MODELS=true

VOLUME ["/paperclip"]
EXPOSE 3100