#!/bin/bash

# variable definitions
scriptdir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
sourcefiles="${scriptdir}/files/.[A-Z,a-z,0-9]*"
target="${HOME}"


# show banner
cat << "EOF"

            █           ▄      ▄▀▀    ▀    ▀▀█
         ▄▄▄█   ▄▄▄   ▄▄█▄▄  ▄▄█▄▄  ▄▄▄      █     ▄▄▄    ▄▄▄
        █▀ ▀█  █▀ ▀█    █      █      █      █    █▀  █  █   ▀
        █   █  █   █    █      █      █      █    █▀▀▀▀   ▀▀▀▄
   █    ▀█▄██  ▀█▄█▀    ▀▄▄    █    ▄▄█▄▄    ▀▄▄  ▀█▄▄▀  ▀▄▄▄▀


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
