export WORKSPACE=$GITHUB_WORKSPACE
GO_PD=$WORKSPACE/bin/go-pd
LINK=$1
TOKEN=$2
chmod +x "$GO_PD"
#Clean The Link Before Assiging Filename
CLEAN_LINK="${LINK%%\?*}"
CLEAN_LINK="${CLEAN_LINK%%\#*}"
FILENAME=$(basename "$CLEAN_LINK")
#Helper Methods
download() {
     wget --show-progress --progress=bar:force:noscroll -O "$2" "$1"
}

create_release() {
    local FILE_NAME="$1"
    local PIXELDRAIN_LINK="$2"
    local TAG_NAME="${FILE_NAME%.*}"
    if [[ -z "$GITHUB_TOKEN" ]]; then
        echo "GITHUB_TOKEN is not set. Cannot create release."
        exit 1
    fi
    FILE_SIZE=$(du -h "$FILE_NAME" | awk '{print $1}')
    echo "Creating GitHub release: $FILE_NAME"
    gh release create "${TAG_NAME}_$(date +%Y%m%d_%H%M)" \
      --title "$FILE_NAME" \
      --notes "Download link: $PIXELDRAIN_LINK\nFile size: $FILE_SIZE" \
      --latest
}

upload() {
    local FILE_PATH="$1"
	if [[ -z "$TOKEN" ]]; then
		echo "TOKEN is not set. Skipping File upload."
		exit 1
	fi
	echo "Uploading file: $FILE_PATH"
	UPLOAD_LINK=$($GO_PD upload -k "$TOKEN" "$FILE_PATH")
    echo "Upload Link: $UPLOAD_LINK"
}


#Download File from Given Link.
if download "$LINK" "$FILENAME"; then
    echo "File downloaded successfully: $FILENAME"
else
    echo "Failed to download file: $LINK"
    exit 1
fi
#Upload File From the $WORKSPACE.
upload "$FILENAME"
#Create Github Release.
if [[ ! -z $UPLOAD_LINK ]]; then
    echo "File is Uploaded on: $UPLOAD_LINK"
    create_release "$FILENAME" "$UPLOAD_LINK"
fi 
