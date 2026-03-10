#!/bin/bash

if [ "$#" -lt 2 ]; then
    echo "Usage: ./agc_extract.sh <accession_id> <output> [thread] [archives_folder] [file_list]"
    echo "Example: ./agc_extract.sh agc_extract.sh SAMEA104410971 ./extracted.fa"
    exit 1
fi

if ! command -v agc >/dev/null 2>&1; then
    echo "Error: 'agc' is not installed. Please install it first."
    echo "Run: conda install -c bioconda agc"
    exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
GEN_ID="$1"
OUTPUT="$2"
THREAD="${3:-1}"
ARCHIVES_FOLDER="${4:-$SCRIPT_DIR/archives}"
FILE_LIST="${5:-$SCRIPT_DIR/file_list.txt}"

mkdir -p "$ARCHIVES_FOLDER"

if [ ! -f "$FILE_LIST" ]; then
    echo "File list not found. Downloading file list (90MB)."
    wget -O "$FILE_LIST" "https://data-access.cesgo.org/index.php/s/9WuPWJL25cYYZml/download"
fi

FILE_INFO=$(grep -F "$GEN_ID" "$FILE_LIST")

# check if any line was found
if [ -z "$FILE_INFO" ]; then
    echo "Error: accession ID '$GEN_ID' not found in $FILE_LIST."
    exit 1
fi

# extract archive name
GEN_ARCHIVE=$(echo "$FILE_INFO" | awk '{print $2}')

echo
echo Found $GEN_ID in $GEN_ARCHIVE

ARCHIVES_LINK="https://data-access.cesgo.org/index.php/s/w8ylLnVjCokP0B5/download?path=%2F&files="

if [ ! -f "$ARCHIVES_FOLDER/$GEN_ARCHIVE.agc" ]; then
    echo "Archive not found. Downloading archive."
    wget -O "$ARCHIVES_FOLDER/$GEN_ARCHIVE.agc" "${ARCHIVES_LINK}${GEN_ARCHIVE}.agc"
fi

echo
echo "Measuring time for AGC extraction:" >&2
time agc getset -t "$THREAD" "$ARCHIVES_FOLDER/$GEN_ARCHIVE.agc" "$GEN_ID" > $OUTPUT
echo
echo "Extracted to $OUTPUT." >&2