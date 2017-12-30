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

# function copyFile(soure, destination)
copyFile()
{
    # define vars
    sourceFile="${1}"
    destinationDir="${2}"
    filename="$(basename "${1}")"
    destinationFile="${destinationDir}/${filename%.tpl}"

    echo "file ${filename}:"

    # check if destination file already exist and create backup
    if [ -f "${destinationFile}" ]
    then
        mv -f "${destinationFile}" "${destinationFile}.save"
        echo "- existing file saved"
    fi

    # copy source to destination
    cp "${sourceFile}" "${destinationDir}"
    echo "- new file copied to ${destinationDir}"

    # handle template files
    if [[ $filename == *".tpl" ]]
    then
        echo "- this is a template file please put in values for the following vars"
        templateFile="${destinationFile}.tpl"
        replaceTemplateVars "${templateFile}"
        # rename template file (remove *.tpl)
        mv -f "${templateFile}" "${destinationFile}"
        echo "- template renamed to ${destinationFile}"
    fi

    # echo newline
    echo ""
}

# function copyDir(soure, destination)
copyDir()
{
    # define vars
    sourceObj="${1}"
    destinationDir="${2}"
    objname="$(basename "${sourceObj}")"
    destinationObj="${destinationDir}/${objname}"
    
    echo "dir ${objname}:"

    # check if destination object already exist and create backup
    if [ -d "${destinationObj}" ]
    then
        rm -Rf "${destinationObj}.save"
        mv -f "${destinationObj}" "${destinationObj}.save"
        echo "- existing dir saved"
    fi

    # copy directory to destination
    cp -r "${sourceObj}" "${destinationDir}"
    echo "- new dir copied to ${destinationDir}"

    # handle template files in directory
    for templateFile in $(find "${destinationObj}" -name "*.tpl")
    do
        echo "- ${templateFile} is a template file please put in values for the following vars"
        replaceTemplateVars "${templateFile}"
        # rename template file (remove *.tpl)
        destinationFile=${templateFile%.tpl}
        mv -f "${templateFile}" "${destinationFile}"
        echo "- template renamed to ${destinationFile}"
    done

    # echo newline
    echo ""
}

# function replaceTemplateVars(filename)
replaceTemplateVars()
{
    # get variables
    filename=${1}

    # ask user for value and replace it in file
    IFS=$'\n'
    for templateVarName in $(grep -o '{{var:.*}}' "${filename}" | sort | uniq)
    do
        read -p " - ${templateVarName}: " templateVarValue
        sed -i "s#${templateVarName}#${templateVarValue}#g" "${filename}"
    done
    unset IFS
}

# walk over all files in ./files directory
shopt -s nullglob
for filename in ${sourcefiles};
do
    # copy files
    if [ -f "${filename}" ]
    then
        copyFile "${filename}" "${target}"
    fi

    # copy directories
    if [ -d "${filename}" ]
    then
        copyDir "${filename}" "${target}"
    fi
done
shopt -u nullglob
