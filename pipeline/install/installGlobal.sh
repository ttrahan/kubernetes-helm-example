#! /bin/sh -e

# install all dependencies required to execute deployment

echo "installing Linux tools..."

DISTRO=alpine
# DISTRO=ubuntu

if [ $DISTRO == ubuntu ]; then
  export TOOL="sudo apt-get"
  export INSTALL_CMD="apt-get install"
elif [ $DISTRO == alpine ]; then
  export TOOL="apk"
  export INSTALL_CMD="apk add"
else
  echo "Linux distro not supported"
  # exit
fi

# update the package index and install tools
$TOOL update
$INSTALL_CMD gettext curl sudo bash
