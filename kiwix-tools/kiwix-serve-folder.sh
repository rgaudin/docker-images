#!/bin/sh

# kiwix-serve wrapper for serving a zim-filled folder
FOLDER=$1
shift 1

if [ -z "${FOLDER}" ];
then
    echo "ERROR: $0 needs a folder path to work off."
    exit 1
fi

if [ -z "$LIBRARY_PATH" ];
then
    AUTO_LIBRARY_FILE=$FOLDER/auto-library.xml
else
    AUTO_LIBRARY_FILE=$LIBRARY_PATH
fi

printf "#!/bin/sh\ngen-kiwix-library $FOLDER\n" > /usr/local/bin/refresh-library && \
chmod +x /usr/local/bin/refresh-library

echo "Starting empty kiwix-serve awaiting population from ${FOLDER}"
echo "<library></library>" > $AUTO_LIBRARY_FILE

function gen_async {
    gen-kiwix-library "${FOLDER}"
    nb_zims=$(cat $AUTO_LIBRARY_FILE |grep "<book" | wc -l)
    echo "Library populated with ${nb_zims} ZIMs"
}
gen_async &

if [ -z "$1" ]; then
    exec kiwix-serve --library --monitorLibrary $AUTO_LIBRARY_FILE
else
    exec kiwix-serve --library --monitorLibrary $@ $AUTO_LIBRARY_FILE
fi
