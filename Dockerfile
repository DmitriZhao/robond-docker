# Using our own fork
FROM docker.lzzhao.app:4567/lzzhao/docker-ubuntu-vnc-desktop/bionic-lxqt
LABEL maintainer "lzzhao@tongji.edu.cn"

# Adding keys for ROS
RUN sed -i "s/mirrors.aliyun.com/mirrors.tuna.tsinghua.edu.cn/g" /etc/apt/sources.list && \
    apt-get update && apt-get install -y dirmngr && \ 
    sh -c 'echo "deb http://mirrors.tuna.tsinghua.edu.cn/ros/ubuntu/ bionic main" > /etc/apt/sources.list.d/ros-latest.list' && \
    apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654

# Installing ROS
RUN apt-get update && apt-get upgrade -y && apt-get install -y ros-melodic-desktop-full python-rosdep python-wstool ros-melodic-ros \
        ros-melodic-openslam-gmapping ros-melodic-joy ros-melodic-ecl-streams ros-melodic-depthimage-to-laserscan \
        ros-melodic-tf2-web-republisher ros-melodic-move-base-flex ros-melodic-eband-local-planner ros-melodic-sbpl-recovery ros-melodic-sbpl-lattice-planner \
		wget git gdb nano screen screenfetch htop iftop iotop xterm proxychains iputils-ping unzip
RUN export http_proxy=http://192.168.1.1:1282 && export https_proxy=http://192.168.1.1:1282 && HTTP_PROXY=http://192.168.1.1:1282 && export HTTPS_PROXY=http://192.168.1.1:1282 && rosdep init && rosdep update

# Update Gazebo
RUN sh -c 'echo "deb http://packages.osrfoundation.org/gazebo/ubuntu-stable `lsb_release -cs` main" > /etc/apt/sources.list.d/gazebo-stable.list' && \
    wget http://packages.osrfoundation.org/gazebo.key -O - | sudo apt-key add - && \
    apt-get update && apt-get install -y gazebo9 libgazebo9-dev

# Set up the workspace
RUN /bin/bash -c "echo 'export HOME=/home/ubuntu' >> /root/.bashrc && source /root/.bashrc" && \
    mkdir -p ~/ros_ws/src && \
    mkdir -p ~/.gazebo/models && cd ~/.gazebo/models && wget https://bitbucket.org/osrf/gazebo_models/get/cda67a315660.zip && unzip cda67a315660.zip && mv osrf-gazebo_models-cda67a315660/* . && rm cda67a315660.zip && rm -r osrf-gazebo_models-cda67a315660 && \
    /bin/bash -c "source /opt/ros/melodic/setup.bash && \
                  cd ~/ros_ws/ && \
                  catkin_make && \
                  echo 'export TURTLEBOT3_MODEL=waffle_pi' >> ~/.bashrc && \
                  echo 'export GAZEBO_MODEL_PATH=~/.gazebo/models' >> ~/.bashrc && \
                  echo 'source /opt/ros/melodic/setup.bash' >> ~/.bashrc && \
                  echo 'source ~/ros_ws/devel/setup.bash' >> ~/.bashrc"
