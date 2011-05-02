#!/bin/bash

Version=$(echo "$1" | sed -e "s/\([^\.]\+\)/\u\1/g")

version=$(echo "$1" | tr '[A-Z]' '[a-z]')

BASEDIR=http://build.chromium.org/f/chromium/snapshots/$Version/
cd ~/Applications/$2

echo "Downloading number of latest revision"
REVNUM=`curl -# $BASEDIR/LATEST`

echo "Found latest revision number $REVNUM, starting download"

curl $BASEDIR/$REVNUM/chrome-$version.zip > $REVNUM.zip

echo "Unzipping..."
unzip $REVNUM.zip 2>&1 > /dev/null
echo "Done."

echo "Moving to Applications/chrome-$version directory..."
rm -rf /Applications/Chromium.app/
mv chrome-$version/Chromium.app/ /Applications/
echo "Done, update successful"

