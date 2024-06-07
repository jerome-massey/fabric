# syntax=docker/dockerfile:1

ARG PYTHON_VERSION=3.10.12
FROM python:${PYTHON_VERSION}-slim as base

# Prevents Python from writing pyc files.
ENV PYTHONDONTWRITEBYTECODE=1

# Keeps Python from buffering stdout and stderr to avoid situations where
# the application crashes without emitting any logs due to buffering.
ENV PYTHONUNBUFFERED=1

WORKDIR /app

# Install applications and dependencies
RUN apt update && apt install -y --no-install-recommends\
    pipx \
    ffmpeg \
    && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 

# Copy the source code into the container.
COPY . .

# Install the application's dependencies.
RUN pipx install .

# Setup path environment variable
ENV PATH="/root/.local/bin:${PATH}"

# Run the application.
CMD ["sleep", "infinity"]