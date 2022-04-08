#!/bin/bash -eu


DIRECTORY_PATH=${1}

#Sprawdzenie, czy ścieżka została podana
if [[ -z "${DIRECTORY_PATH}" ]]; then
    echo "Nie podano katalogu"
    exit 1
fi

# Sprawdzenie, poprawności ścieżki
if [[ ! -d ${DIRECTORY_PATH} ]]; then
    echo "Ścieżka jest niepoprawna"
    exit 1
fi


for FILE in $(ls ${DIRECTORY_PATH}); do

    EXTENSION=${FILE##*.}
    # Jeśli katalog
    if [[ -d ${DIRECTORY_PATH}/${FILE} ]]; then

        if [[ "$EXTENSION" == "bak" ]]; then
            chmod 004 ${DIRECTORY_PATH}/${FILE}

        elif [[ "${EXTENSION}" == "tmp" ]]; then
            chmod -R 777 ${DIRECTORY_PATH}/${FILE}
        fi

    # Jeśli plik regularny
    elif [[ -f ${DIRECTORY_PATH}/${FILE} ]]; then

        if [[ ${EXTENSION} == "bak" ]]; then
            chmod uo-w ${DIRECTORY_PATH}/${FILE}

        elif [[ ${EXTENSION} == "txt" ]]; then
            chmod 421 ${DIRECTORY_PATH}/${FILE}

        elif [[ ${EXTENSION} == "exe" ]]; then
            chmod 4111 ${DIRECTORY_PATH}/${FILE}
        fi
    fi
done
