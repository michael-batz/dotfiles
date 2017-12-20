#!/bin/bash

# variable definitions
scriptdir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
sourcefiles="${scriptdir}/files/.[A-Z,a-z,0-9]*"
target="${HOME}"


# show banner
cat << "EOF"
          _           _      __   _   _              
       __| |   ___   | |_   / _| (_) | |   ___   ___ 
      / _` |  / _ \  | __| | |_  | | | |  / _ \ / __|
  _  | (_| | | (_) | | |_  |  _| | | | | |  __/ \__ \
 (_)  \__,_|  \___/   \__| |_|   |_| |_|  \___| |___/

---------------------------------------------------------------
 SETUP
---------------------------------------------------------------
EOF

echo $scriptdir

# function copyFile(soure, destination)
copyFile()
{
    # copy file to target
    echo "copy $1 to $2..."
    cp $1 $2
}

# walk over all files in ./files directory and copy
shopt -s nullglob
for filename in ${sourcefiles};
do
    copyFile ${filename} ${target}
done
shopt -u nullglob
