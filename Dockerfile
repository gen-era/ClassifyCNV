 ARG RELEASE
 ARG LAUNCHPAD_BUILD_ARCH
 LABEL org.opencontainers.image.ref.name=ubuntu
 LABEL org.opencontainers.image.version=22.04
ADD file:c646150c866c8b5ece67bc79c610718acf858034fa22502b0dba3d38c53fc9a9 in / 
 CMD ["/bin/bash"]
ENV DEBIAN_FRONTEND=noninteractive
RUN /bin/sh -c apt-get update && apt-get install -y --no-install-recommends build-essential libcurl4-openssl-dev libssl-dev libssh2-1-dev libxml2-dev zlib1g-dev r-base python3.6 python3-pip python3-setuptools python3-dev curl # buildkit
RUN /bin/sh -c apt-get install -y --no-install-recommends wget apt-utils libbz2-dev liblzma-dev libpng-dev samtools tabix libdbi-perl bioperl libbio-db-hts-perl libmodule-build-perl git libmysqlclient-dev libdbd-mysql-perl libtry-tiny-perl libwww-perl # buildkit
RUN /bin/sh -c apt-get update && apt-get install -y libboost-dev libgtest-dev libboost-all-dev gawk libncurses5-dev parallel # buildkit
RUN /bin/sh -c pip install numpy # buildkit
RUN /bin/sh -c pip install pandas # buildkit
RUN /bin/sh -c set -e       && ln -sf bash /bin/sh       && ln -s python3 /usr/bin/python       && apt-get update       && apt-get install -y wget       && apt-get -y dist-upgrade       && apt-get -y install --no-install-recommends --no-install-suggests         gcc python3-dev python3-distutils       && apt-get -y autoremove       && apt-get clean       && rm -rf /var/lib/apt/lists/* # buildkit
RUN /bin/sh -c wget https://github.com/arq5x/bedtools2/releases/download/v2.29.1/bedtools-2.29.1.tar.gz && tar -zxvf bedtools-2.29.1.tar.gz && cd bedtools2 && make # buildkit
ENV PATH=/bedtools2/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
COPY ClassifyCNV /ClassifyCNV # buildkit
WORKDIR /ClassifyCNV
