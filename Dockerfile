# Kudos to DOROWU for his amazing VNC KDE image
FROM dorowu/ubuntu-desktop-lxde-vnc:bionic
LABEL maintainer "lzzhao@tongji.edu.cn"

# Installing ROS
RUN echo "deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic main multiverse restricted universe\ndeb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-backports main multiverse restricted universe\ndeb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-proposed main multiverse restricted universe\ndeb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-security main multiverse restricted universe\ndeb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-updates main multiverse restricted universe\ndeb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic main multiverse restricted universe\ndeb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-backports main multiverse restricted universe\n" >  /etc/apt/sources.list && \
    apt-get update && apt-get install -y gnupg2 && \
    sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list' && \
    curl -sSL 'http://keyserver.ubuntu.com/pks/lookup?op=get&search=0xC1CF6E31E6BADE8868B172B4F42ED6FBAB17C654' | sudo apt-key add - && \
    apt-get update && apt-get install -y ros-melodic-desktop-full ros-melodic-perception python-rosdep \
		ros-melodic-openslam-gmapping ros-melodic-joy ros-melodic-ecl-streams ros-melodic-depthimage-to-laserscan ros-melodic-webots-ros\
        wget git nano screen screenfetch htop xterm proxychains
RUN rosdep init && rosdep update

# Install Webots
RUN wget -qO- https://cyberbotics.com/Cyberbotics.asc | sudo apt-key add - && \
    apt-add-repository 'deb https://cyberbotics.com/debian/ binary-amd64/' && \
    apt-get update && apt-get install -y webots

# Set up the workspace
RUN useradd --create-home --no-log-init --shell /bin/bash ubuntu && adduser ubuntu sudo && echo 'ubuntu:ubuntu' | chpasswd && chown -hR ubuntu:ubuntu /home/ubuntu/
USER ubuntu
RUN  mkdir -p ~/ros_ws/src && \
    /bin/bash -c "source /opt/ros/melodic/setup.bash && \
                  cd ~/ros_ws/ && \
                  catkin_make && \
                  echo 'source ~/ros_ws/devel/setup.bash' >> ~/.bashrc && \
                  echo 'export WEBOTS_HOME=/usr/local/webots' >> ~/.bashrc && \
                  echo 'export LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:\$WEBOTS_HOME/lib/controller' >> ~/.bashrc" && \
    cd ~/ros_ws && rosdep fix-permissions && rosdep update && rosdep install --from-paths src --ignore-src --rosdistro=melodic -y && \
    /bin/bash -c "source /opt/ros/melodic/setup.bash && \
                  cd ~/ros_ws/ && rm -rf build devel && \
                  catkin_make"
USER root
