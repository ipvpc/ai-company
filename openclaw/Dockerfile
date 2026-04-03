FROM ghcr.io/openclaw/openclaw:latest

USER root

RUN apt update && apt install python3-full -y

RUN curl -LsSf https://astral.sh/uv/install.sh | sh
RUN echo "source $HOME/.local/bin/env" >> /root/.bashrc
RUN echo 'eval "$(uv generate-shell-completion bash)"' >> /root/.bashrc

ENV PATH="/root/.local/bin:$PATH"

SHELL ["/bin/bash", "-c"]
RUN source /root/.bashrc

RUN apt install pipx -y
RUN pipx install memsearch[ollama]
RUN npm install -g @openai/codex

RUN mkdir /home/node/.memsearch/
COPY config.toml  /home/node/.memsearch/
RUN npm install -g npm@11.11.0
#RUN npx -y firecrawl-cli init --browser --all
RUN npm install -g acpx@latest
RUN curl -fsSL https://raw.githubusercontent.com/nashsu/opencli-rs/main/scripts/install.sh | sh

USER node

ENV PATH="/home/node/.local/bin:${PATH}:/home/node/.cargo/env"

RUN python3 -m pipx install memsearch[ollama]

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs -y | sh
