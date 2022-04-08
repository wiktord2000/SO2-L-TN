#!/bin/bash -eu


FIRST_PATH=${1}
SECOND_PATH=${2}

#Sprawdzenie, czy ścieżki zostały podane
if [[ -z "${FIRST_PATH}" ]] || [[ -z "${SECOND_PATH}" ]]; then
    echo "Nie wprowadzono wszystkich argumentów"
    exit 1
fi


# Sprawdzenie, poprawności ścieżek 
if [[ ! -d ${FIRST_PATH} ]] && [[ ! -d ${SECOND_PATH} ]]; then
    echo "Ścieżki są nieprawidłowe"
    exit 1
fi

if [[ ! -d ${FIRST_PATH} ]]; then
    echo "Pierwsza ścieżka jest nieprawidłowa"
    exit 1
fi

if [[ ! -d ${SECOND_PATH} ]]; then
    echo "Druga ścieżka jest nieprawidłowa"
    exit 1
fi

# Wyświetlenie zawartości z pierwszego foldera i wykonanie operacji na poszczególnych plikach
for FILE in $(ls ${FIRST_PATH}); do
    if [[ -d ${FIRST_PATH}/${FILE} ]]; then
        echo "${FILE} jest katalogiem"
        # r -relative, s- symbolic
        ln -sr ${FIRST_PATH}/${FILE} "${SECOND_PATH}/${FILE^^}_ln" 

    elif [[ -h ${FIRST_PATH}/${FILE} ]]; then
        echo "${FILE} jest dowiązaniem symbolicznym"

    elif [[ -f ${FIRST_PATH}/${FILE} ]]; then
        echo "${FILE} jest plikiem regularnym"
        FILE_UPPERCASE=${FILE^^}
        # Dla plików z rozszerzeniem
        if [[ "${FILE##*.}" != "${FILE}" ]]; then
            ln -sr ${FIRST_PATH}/${FILE} ${SECOND_PATH}/${FILE_UPPERCASE%.*}_ln.${FILE##*.}
        # Dla plików bez rozszerzenia
        else
            ln -sr ${FIRST_PATH}/${FILE} ${SECOND_PATH}/${FILE_UPPERCASE%.*}_ln
        fi
    fi
done

