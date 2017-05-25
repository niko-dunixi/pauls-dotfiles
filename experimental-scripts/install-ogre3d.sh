#!/usr/bin/env bash
set -e

# Directions were from here
# http://www.ogre3d.org/tikiwiki/CMake+Quick+Start+Guide?tikiversion=Mac+OS+X

# checkout_dir="~/mercurial/"
checkout_dir="/tmp/"

mkdir -p $checkout_dir

cd $checkout_dir

if [ -d "ogre" ]; then
  echo "Already checked out. Let's hg-purge."
  cd ogre
  hg purge || echo "Can't puge, let's just hope for the best..."
else
  echo "Cloning source from scratch"
  hg clone https://bitbucket.org/sinbad/ogre/
  cd ogre
fi

mkdir -p build
cd build
echo "Entering build directory"

echo "Running cmake -GXcode .."
sleep 5s
cmake -GXcode ..

echo "Running xcodebuild -configuration RelWithDebInfo"
sleep 5s
xcodebuild -configuration RelWithDebInfo

echo "Need sudo access to install framework system wide"
# sudo cp -r ./lib/macosx/RelWithDebInfo/Ogre.framework /Library/Frameworks
