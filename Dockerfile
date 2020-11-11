FROM python:3.7-slim

WORKDIR /app

COPY requirements.txt ./

RUN apt update && \
  apt install -y --no-install-recommends ffmpeg wget && \
  python -m pip install -r requirements.txt && \
  # cleanup
  apt autoremove -y && \
  rm -rf /var/lib/apt/lists/*