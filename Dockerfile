FROM python:3-alpine

LABEL maintainer="xnetcat (Jakub)"

# Install dependencies
RUN apk add --no-cache \
    ca-certificates \
    ffmpeg \
    openssl \
    aria2 \
    g++ \
    git \
    py3-cffi \
    libffi-dev \
    zlib-dev

# Install poetry and update pip/wheel
RUN pip install --upgrade pip poetry wheel spotipy

# Copy requirements and README
COPY poetry.lock pyproject.toml /
COPY README.md /

# Add source code files
ADD . .

# Install spotdl requirements and itself
RUN poetry install

# Create music directory
RUN mkdir /music

# Create a volume for the output directory
VOLUME /music

# Change CWD to /music
WORKDIR /music

# Entrypoint command
ENTRYPOINT ["poetry", "run", "spotdl"]
