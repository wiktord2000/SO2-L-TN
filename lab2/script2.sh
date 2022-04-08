#!/bin/bash -eu

FOLDER_PATH=${1}
OUTPUT_FILE=${2}


#Sprawdzenie, czy ścieżki została podana
if [[ -z "${PATH}" ]]; then
    echo "Nie podano ścieżki"
    exit 1
fi

#Sprawdzenie, czy podano drugi argument
if [[ -z "${OUTPUT_FILE}" ]]; then
    echo "Nie podano pliku"
    exit 1
fi

# Sprawdzenie, poprawności ścieżek 
if [[ ! -d ${FOLDER_PATH} ]] && [[ ! -f ${OUTPUT_FILE} ]]; then
    echo "Ścieżki są nieprawidłowe"
    exit 1
fi


# Usuwanie uszkodzonych dowiązań symbolicznych i zapis do pliku
for FILE in $(find ${FOLDER_PATH} -xtype l); do
    ONLY_FILE_NAME=${FILE##*/}
    echo "${ONLY_FILE_NAME,,}-$(date +%F)" >> ${OUTPUT_FILE}
    rm -rf ${FILE}
done