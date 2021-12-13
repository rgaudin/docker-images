#!/bin/sh

FOLDER=$1

if [ -z "${FOLDER}" ];
then
    echo "unable to gen library without a folder."
    exit 1
fi

AUTO_LIBRARY_FILE=$FOLDER/auto-library.xml
AUTO_LIBRARY_FILE_TEMP=$AUTO_LIBRARY_FILE.tmp

rm -f $AUTO_LIBRARY_FILE_TEMP

find $FOLDER -name '*.zim' -exec kiwix-manage $AUTO_LIBRARY_FILE_TEMP add {} \;
mv $AUTO_LIBRARY_FILE_TEMP $AUTO_LIBRARY_FILE
