# Kudos to DOROWU for his amazing VNC KDE image
FROM dorowu/ubuntu-desktop-lxde-vnc:bionic
LABEL maintainer "lzzhao@tongji.edu.cn"

# Installing ROS
RUN echo "deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic main multiverse restricted universe\ndeb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-backports main multiverse restricted universe\ndeb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-proposed main multiverse restricted universe\ndeb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-security main multiverse restricted universe\ndeb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-updates main multiverse restricted universe\ndeb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic main multiverse restricted universe\ndeb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-backports main multiverse restricted universe\n" >  /etc/apt/sources.list && \
    apt-get update && apt-get install -y gnupg2 && \
    sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list' && \
    curl -sSL 'http://keyserver.ubuntu.com/pks/lookup?op=get&search=0xC1CF6E31E6BADE8868B172B4F42ED6FBAB17C654' | sudo apt-key add - && \
    apt-get update && apt-get install -y ros-melodic-desktop python-rosdep\
		wget git nano screen htop
RUN rosdep init && rosdep update

# Update Gazebo
RUN curl -sSL http://get.gazebosim.org | sh

# Set up the workspace
RUN /bin/bash -c "echo 'export HOME=/home/ubuntu' >> /root/.bashrc && source /root/.bashrc" && \
    mkdir -p ~/ros_ws/src && \
    /bin/bash -c "source /opt/ros/melodic/setup.bash && \
                  cd ~/ros_ws/ && \
                  catkin_make && \
                  echo 'export GAZEBO_MODEL_PATH=~/ros_ws/src/kinematics_project/kuka_arm/models' >> ~/.bashrc && \
                  echo 'source ~/ros_ws/devel/setup.bash' >> ~/.bashrc"

# Updating ROSDEP and installing dependencies
RUN cd ~/ros_ws && rosdep update && rosdep install --from-paths src --ignore-src --rosdistro=melodic -y && \
    /bin/bash -c "source /opt/ros/melodic/setup.bash && \
                  cd ~/ros_ws/ && rm -rf build devel && \
                  catkin_make" && \
    /bin/bash -c "echo 'source ~/ros_ws/devel/setup.bash' >> /root/.bashrc"
