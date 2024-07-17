#!/bin/sh -e
#Author: Jason Campisi
#Date: 9/20/2024
#version 0.2.7
#For macOS x or higher
#Released under the GPL v2 or higher
NAME="k"
EXT="pl"
FILE="$NAME.$EXT"
LOCATION="/opt/local/bin/"
echo "$FILE installer:";

 echo " Checking if '$FILE' exists in the current folder..."
   if [ ! -n "$FILE" ]; then
      echo " Error - Filename is not set!"
      exit 1;
   fi
 echo " ...found!";
 
echo " Setting file to executable...";
chmod +x ./$FILE


echo " Checking if you have the clearance to install this ...";
if [ "$(whoami)" != 'root' ]; then
	echo " You do not have permission to install ./$FILE";
	echo " ->You must be a root user.";
	echo " ->Try instead: sudo $0";
	exit 1;
else
	echo " Root access granted for $0";	
fi

echo " Installing $NAME to $LOCATION ...";

cp -rf ./$FILE $LOCATION$NAME
echo " Setup complete."
echo "Testing install with this command\n>$NAME --version";
$NAME --version
