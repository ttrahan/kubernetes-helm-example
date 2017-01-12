#! /bin/sh -e

# install all dependencies required to execute deployment

echo "installing Linux tools..."

DISTRO=alpine
# DISTRO=ubuntu

if [ $DISTRO == ubuntu ]; then
  TOOL="sudo apt-get"
  INSTALL_CMD="apt-get install"
elif [ $DISTRO == alpine ]; then
  TOOL="apk"
  INSTALL_CMD="apk add"
else
  echo "Linux distro not supported"
  # exit
fi

# update the package index and install tools
$TOOL update
$INSTALL_CMD gettext curl sudo bash
