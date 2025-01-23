FROM ubuntu:22.04

LABEL org.opencontainers.image.ref.name="classifycnv" \
      org.opencontainers.image.version="1.0"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    bedtools \
    python3 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && ln -s /usr/bin/python3 /usr/bin/python

COPY . /ClassifyCNV
WORKDIR /ClassifyCNV

CMD ["/bin/bash"]
