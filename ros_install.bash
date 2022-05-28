#!/bin/bash
set -e

UBUNTU_CODENAME=$(lsb_release -s -c)
UBUNTU_VERSION=$(lsb_release -r -s | cut -f 1 -d '.')
case $UBUNTU_CODENAME in
    trusty)
        ROS_DISTRO=indigo;;
    zesty)
        ROS_DISTRO=lunar;;
    xenial)
        ROS_DISTRO=kinetic;;
    bionic)
        ROS_DISTRO=melodic;;
    focal)
        ROS_DISTRO=noetic;;
    *)
        echo "Unable to match Ubuntu release (named $UBUNTU_CODENAME) to a ROS version"
    exit 0
esac

sudo sh -c "echo \"deb http://packages.ros.org/ros/ubuntu $UBUNTU_CODENAME main\" > /etc/apt/sources.list.d/ros-latest.list"
wget -qO - http://packages.ros.org/ros.key | sudo apt-key add -

echo "Updating package lists ..."
sudo apt-get -qq update

echo "Installing ROS $ROS_DISTRO ..."
sudo apt-get -qq install ros-$ROS_DISTRO-desktop > /dev/null

if [ "$UBUNTU_VERSION" -ge "20" ]; then
    sudo apt-get -qq install python3-rosinstall python3-rosdep > /dev/null
else
    sudo apt-get -qq install python-rosinstall python-rosdep > /dev/null
fi

source /opt/ros/$ROS_DISTRO/setup.bash

# Prepare rosdep to install dependencies.
echo "Updating rosdep ..."
if [ ! -d /etc/ros/rosdep ]; then
    sudo rosdep init > /dev/null
fi
rosdep update > /dev/null

echo "ROS Installed Successfully."
