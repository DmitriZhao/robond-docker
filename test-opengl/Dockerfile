FROM nvidia/cudagl:10.2-runtime

RUN echo "deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic main multiverse restricted universe\ndeb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-backports main multiverse restricted universe\ndeb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-proposed main multiverse restricted universe\ndeb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-security main multiverse restricted universe\ndeb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-updates main multiverse restricted universe\ndeb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic main multiverse restricted universe\ndeb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-backports main multiverse restricted universe\n" >  /etc/apt/sources.list && \
    apt-get update && apt-get install -y --no-install-recommends \
        mesa-utils && \
    rm -rf /var/lib/apt/lists/*
