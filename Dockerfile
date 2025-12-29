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
    git \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Create virtual environment
RUN python3 -m venv /venv && \
    /venv/bin/pip install --upgrade pip setuptools wheel

# Install appxdl FROM GITHUB SOURCE (THIS IS THE FIX)
RUN /venv/bin/pip install git+https://github.com/masterapi/appxdl.git

# Install your project dependencies
RUN /venv/bin/pip install -r master.txt

# Set PATH
ENV PATH="/venv/bin:$PATH"

# Run application
CMD ["python3", "main.py"]
