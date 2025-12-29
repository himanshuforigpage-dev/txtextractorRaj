FROM sailvessel/ubuntu:latest

WORKDIR /app
COPY . .

# Install system dependencies
RUN apt-get update && \
    apt-get install --no-install-recommends -y --fix-missing \
    python3 \
    python3-pip \
    python3-dev \
    python3-venv \
    ffmpeg \
    aria2 \
    wget \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Install appxdl from GitHub Releases (FIXED)
RUN wget -O /usr/local/bin/appxdl \
    https://github.com/masterapi/appxdl/releases/latest/download/appxdl-linux-amd64 \
    && chmod +x /usr/local/bin/appxdl

# Create virtual environment and install Python deps
RUN python3 -m venv /venv && \
    /venv/bin/pip install --upgrade pip && \
    /venv/bin/pip install -r master.txt

# Set PATH
ENV PATH="/usr/local/bin:/venv/bin:$PATH"

# Run application
CMD ["python3", "main.py"]
