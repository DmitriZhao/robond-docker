FROM dmitrizhao/ubuntu-vnc-ros-perception-desktop:melodic
LABEL maintainer "lzzhao@tongji.edu.cn"
RUN wget -qO- https://cyberbotics.com/Cyberbotics.asc | apt-key add - && \
    apt-add-repository 'deb https://cyberbotics.com/debian/ binary-amd64/' && \
    apt-get update && apt-get install -y webots ros-melodic-webots-ros && \
    /bin/bash -c "echo 'export WEBOTS_HOME=/usr/local/webots' >> ~/.bashrc && \
                  echo 'export LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:\$WEBOTS_HOME/lib/controller' >> ~/.bashrc"