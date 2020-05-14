# Using our own fork
FROM docker.lzzhao.app:4567/lzzhao/docker-ubuntu-vnc-desktop/bionic-lxqt
LABEL maintainer "lzzhao@tongji.edu.cn"

# Adding keys for ROS
RUN apt-get update && apt-get install -y dirmngr && \ 
    sh -c 'echo "deb https://mirrors.tuna.tsinghua.edu.cn/ros/ubuntu/ bionic main" > /etc/apt/sources.list.d/ros-latest.list' && \
    apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654

# Installing ROS
RUN apt-get update && apt-get install -y ros-melodic-desktop-full python-rosdep \
        ros-melodic-openslam-gmapping ros-melodic-joy ros-melodic-ecl-streams ros-melodic-depthimage-to-laserscan \
        ros-melodic-tf2-web-republisher ros-melodic-move-base-flex ros-melodic-eband-local-planner ros-melodic-sbpl-recovery ros-melodic-sbpl-lattice-planner \
		wget git nano screen screenfetch htop iftop iotop xterm proxychains iputils-ping unzip
RUN rosdep init && rosdep update

# Update Gazebo
RUN sh -c 'echo "deb http://packages.osrfoundation.org/gazebo/ubuntu-stable `lsb_release -cs` main" > /etc/apt/sources.list.d/gazebo-stable.list' && \
    wget http://packages.osrfoundation.org/gazebo.key -O - | sudo apt-key add - && \
    apt-get update && apt-get install -y gazebo9 libgazebo9-dev

# Set up the workspace
RUN /bin/bash -c "echo 'export HOME=/home/ubuntu' >> /root/.bashrc && source /root/.bashrc" && \
    mkdir -p ~/ros_ws/src && \
    mkdir -p ~/.gazebo/models && cd ~/.gazebo/models && wget https://bitbucket.org/osrf/gazebo_models/get/e6d645674e8a.zip && unzip e6d645674e8a.zip && mv osrf-gazebo_models-e6d645674e8a/* . && rm e6d645674e8a.zip && rm -r osrf-gazebo_models-e6d645674e8a && \
    /bin/bash -c "source /opt/ros/melodic/setup.bash && \
                  cd ~/ros_ws/ && \
                  catkin_make && \
                  echo 'export GAZEBO_MODEL_PATH=~/.gazebo/models' >> ~/.bashrc && \
                  echo 'source ~/ros_ws/devel/setup.bash' >> ~/.bashrc"

# Sourcing
RUN /bin/bash -c "source /opt/ros/melodic/setup.bash && \
                  cd ~/ros_ws/ && rm -rf build devel && \
                  catkin_make"
