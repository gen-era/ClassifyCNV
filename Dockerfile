FROM ubuntu:22.04

# Set labels
LABEL org.opencontainers.image.ref.name="ubuntu" \
      org.opencontainers.image.version="22.04"

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV PATH=/bedtools2/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# Install base dependencies and Python
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    libcurl4-openssl-dev \
    libssl-dev \
    libssh2-1-dev \
    libxml2-dev \
    zlib1g-dev \
    r-base \
    python3.6 \
    python3-pip \
    python3-setuptools \
    python3-dev \
    python3-distutils \
    curl \
    wget \
    apt-utils \
    libbz2-dev \
    liblzma-dev \
    libpng-dev \
    samtools \
    tabix \
    libdbi-perl \
    bioperl \
    libbio-db-hts-perl \
    libmodule-build-perl \
    git \
    libmysqlclient-dev \
    libdbd-mysql-perl \
    libtry-tiny-perl \
    libwww-perl \
    libboost-dev \
    libgtest-dev \
    libboost-all-dev \
    gawk \
    libncurses5-dev \
    parallel \
    gcc && \
    apt-get -y dist-upgrade && \
    apt-get -y autoremove && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set up Python symlinks and install Python packages
RUN ln -sf bash /bin/sh && \
    ln -s python3 /usr/bin/python && \
    pip install numpy pandas

# Install bedtools
RUN wget https://github.com/arq5x/bedtools2/releases/download/v2.29.1/bedtools-2.29.1.tar.gz && \
    tar -zxvf bedtools-2.29.1.tar.gz && \
    cd bedtools2 && \
    make && \
    rm ../bedtools-2.29.1.tar.gz

# Set up working directory and copy application
WORKDIR /ClassifyCNV
COPY ClassifyCNV .

# Set default command
CMD ["/bin/bash"]
