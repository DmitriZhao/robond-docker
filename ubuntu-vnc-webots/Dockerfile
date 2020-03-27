FROM dmitrizhao/ubuntu-vnc-desktop-wrapper:bionic
LABEL maintainer "lzzhao@tongji.edu.cn"
RUN echo "deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic main multiverse restricted universe\ndeb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-backports main multiverse restricted universe\ndeb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-proposed main multiverse restricted universe\ndeb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-security main multiverse restricted universe\ndeb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-updates main multiverse restricted universe\ndeb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic main multiverse restricted universe\ndeb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-backports main multiverse restricted universe\n" >  /etc/apt/sources.list && \
    apt-get update && apt-get install -y gnupg2 && \
    curl -sSL https://cyberbotics.com/Cyberbotics.asc | apt-key add - && \
    apt-add-repository 'deb http://cyberbotics.com/debian/ binary-amd64/' && \
    apt-get install -y webots
RUN /bin/bash -c "mkdir ~ && \
                  echo 'export WEBOTS_HOME=/usr/local/webots' >> ~/.bashrc && \
                  echo 'export LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:\$WEBOTS_HOME/lib/controller' >> ~/.bashrc" && \
    apt-get install -y xserver-xorg-video-nvidia-440 xserver-xorg-video-all
