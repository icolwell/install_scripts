#!/bin/bash
set -e

UBUNTU_CODENAME=$(lsb_release -s -c)
case $UBUNTU_CODENAME in
    trusty)
        ROS_DISTRO=indigo;;
    zesty)
        ROS_DISTRO=lunar;;
    xenial)
        ROS_DISTRO=kinetic;;
    bionic)
        ROS_DISTRO=melodic;;
    *)
        echo "Unable to match Ubuntu release (named $UBUNTU_CODENAME) to a ROS version"
    exit 1
esac

sudo sh -c "echo \"deb http://packages.ros.org/ros/ubuntu $UBUNTU_CODENAME main\" > /etc/apt/sources.list.d/ros-latest.list"
wget -qO - http://packages.ros.org/ros.key | sudo apt-key add -

echo "Updating package lists ..."
sudo apt-get -qq update

echo "Installing ROS $ROS_DISTRO ..."
sudo apt-get -qq install ros-$ROS_DISTRO-desktop python-rosinstall > /dev/null

source /opt/ros/$ROS_DISTRO/setup.bash

# Prepare rosdep to install dependencies.
echo "Updating rosdep ..."
if [ ! -d /etc/ros/rosdep ]; then
    sudo rosdep init > /dev/null
fi
rosdep update > /dev/null

echo "ROS Installed Successfully."
