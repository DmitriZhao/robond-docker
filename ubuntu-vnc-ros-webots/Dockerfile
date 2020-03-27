FROM dmitrizhao/ubuntu-vnc-webots:bionic
LABEL maintainer "lzzhao@tongji.edu.cn"
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list' && \
    curl -sSL 'http://keyserver.ubuntu.com/pks/lookup?op=get&search=0xC1CF6E31E6BADE8868B172B4F42ED6FBAB17C654' | apt-key add - && \
    apt-get update && apt-get install -y ros-melodic-desktop ros-melodic-perception python-rosdep \
		ros-melodic-openslam-gmapping ros-melodic-joy ros-melodic-ecl-streams ros-melodic-webots-ros ros-melodic-depthimage-to-laserscan \
        wget git nano screen screenfetch htop xterm proxychains g++
RUN rosdep init && rosdep update && \
    mkdir -p ~/ros_ws/src && \
    /bin/bash -c "source /opt/ros/melodic/setup.bash && \
                  cd ~/ros_ws/ && \
                  catkin_make && \
                  echo 'source ~/ros_ws/devel/setup.bash' >> ~/.bashrc"
