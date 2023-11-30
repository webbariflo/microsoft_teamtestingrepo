# Getting base image
FROM ros: ubuntu 20.04

# Working directory
WORKDIR /rosuser
# Set the DEBIAN_FRONTEND environment variable to noninteractive
ENV DEBIAN_FRONTEND=${DEBIAN_FRONTEND}

# Copy the ROS app to the current directory of the container
COPY . .

# Set the default keyboard layout to avoid the interactive prompt
RUN echo "keyboard-configuration keyboard-configuration/layout select English (US)" | debconf-set-selections

# Install ROS and build your ROS package
RUN apt-get update && \
    apt-get install -y curl gnupg2 lsb-release && \
    apt-get upgrade -y && \
    curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add - && \
    sudo apt install -y ros-noetic-desktop-full && \
    source /opt/ros/noetic/setup.bash && \
    catkin_make

# Start your ROS nodes
CMD ["roslaunch", "src", "src.launch"]
