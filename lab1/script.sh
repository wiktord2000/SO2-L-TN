#!/bin/bash


# Uwaga nie może być spacji pomiędzy znakiem = 
SOURCE_DIR="lab_uno"
RM_LIST="2remove"
TARGET_DIR="bakap"

# Uwaga nie może być spacji w {}
if [[ ! -d ${TARGET_DIR} ]]; then
    mkdir ${TARGET_DIR}
fi


# Wyświetlenie plików
# echo "${FILES}"
FILES=$(cat ${RM_LIST})


# Pętla usuwająca pliki o nazwach wskazanych w 2remove
for FILE in ${FILES}; do

    if [[ -e ${SOURCE_DIR}/${FILE} ]]; then
        rm -rf ${SOURCE_DIR}/${FILE}
    fi
done

# Sprawdzanie pozostałych katalogów

for FILE in $(ls ${SOURCE_DIR}); do
    if [[ -d ${SOURCE_DIR}/${FILE} ]]; then
        # echo "${FILE} jest katalogiem"
        cp -r ${SOURCE_DIR}/${FILE} ${TARGET_DIR}

    elif [[ -f ${SOURCE_DIR}/${FILE} ]]; then
        # echo "${FILE} jestem plikiem regularnym"
        mv ${SOURCE_DIR}/${FILE} ${TARGET_DIR}
    fi
done


# Zliczamy ile zostało plików po wcześniejszych operacjach i wyświetlamy odpowiedni komunikat

OTHER_FILES=$(ls ${SOURCE_DIR} | wc -w)

if [[ ${OTHER_FILES} -ne 0 ]]; then

    echo "jeszcze coś zostało"
    if [[ ${OTHER_FILES} -gt 4 ]]; then
        echo "zostały więcej niż 4 pliki"
    elif [[ ${OTHER_FILES} -ge 2 ]]; then
        echo "zostały co najmniej 2 pliki, ale nie więcej niż 4"
    else
        echo "został jeden plik"
    fi

else
    echo "tu był Kononowicz"
fi

# echo "Current date: $(date +%F)"
zip -r "${TARGET_DIR}$(date +%F).zip" ${TARGET_DIR}



