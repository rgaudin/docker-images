#!/bin/sh

FOLDER=$1

if [ -z "${FOLDER}" ];
then
    echo "unable to gen library without a folder."
    exit 1
fi

if [ -z "$LIBRARY_PATH" ];
then
    AUTO_LIBRARY_FILE=$FOLDER/auto-library.xml
else
    AUTO_LIBRARY_FILE=$LIBRARY_PATH
fi
AUTO_LIBRARY_FILE_TEMP=$AUTO_LIBRARY_FILE.tmp

rm -f $AUTO_LIBRARY_FILE_TEMP

find $FOLDER -name '*.zim' -exec kiwix-manage $AUTO_LIBRARY_FILE_TEMP add {} \;
mv $AUTO_LIBRARY_FILE_TEMP $AUTO_LIBRARY_FILE
