# We're using Debian Slim Buster image
FROM python:3.8.5-slim-buster

ENV PIP_NO_CACHE_DIR 1

WORKDIR /root/spambot


# Installing Required Packages
RUN apt-get update
RUN apt install upgrade -y && \
    apt install --no-install-recommends -y \
    bash \
    curl \
    figlet \
    git \
    util-linux \
    libffi-dev \
    libjpeg-dev \
    python3-pip \
    python3-requests \
    python3-tz \
    python3-aiohttp \
    openssl \
    pv \
    jq \
    wget \
    python3 \
    python3-dev \
    && rm -rf /var/lib/apt/lists /var/cache/apt/archives /tmp

# Pypi package Repo upgrade
RUN pip3 install --upgrade pip setuptools

# Copy Python Requirements to /root/spambot
RUN git clone https://github.com/Gladiators-Projects/spambot /root/spambot


#Copy config file to /root/spambot/spambot
COPY ./spambot/sample_config.py ./spambot/config.py* /root/spambot/spambot/

ENV PATH="/home/bot/bin:$PATH"

# Install requirements
RUN pip3 install -U -r requirements.txt

# Starting Worker
CMD ["python3","-m","spambot"]
