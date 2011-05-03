#!/bin/bash

Platform='unknown'
platform='unknown'

unamestr=`uname`

case "$unamestr" in
	'Darwin')
		Platform="Mac"
		platform="mac"
;;

	'Linux')
		Platform="Linux"
		platform="linux"
;;

	*)
		if [[ $# == 2 ]]; then
			Platform=$(echo "$2" | sed -e "s/\([^\.]\+\)/\u\1/g")
			platform=$(echo "$2" | tr '[A-Z]' '[a-z]')
		elif [[ $# == 1 ]]; then
			Platform=$(echo "$1" | sed -e "s/\([^\.]\+\)/\u\1/g")
			platform=$(echo "$1" | tr '[A-Z]' '[a-z]')
		fi

;;
esac

echo "$unamestr :: $Platform : $platform"
echo


BASEDIR=http://build.chromium.org/f/chromium/snapshots/$Platform/
cd ~/Applications/$1

echo "Downloading number of latest revision"
REVNUM=`curl -# $BASEDIR/LATEST`

echo "Found latest revision number $REVNUM, starting download"

curl $BASEDIR/$REVNUM/chrome-$platform.zip > $REVNUM.zip

echo "Unzipping..."
unzip $REVNUM.zip 2>&1 > /dev/null
echo "Done."

echo "Moving to Applications directory..."
echo "Done, update successful"

