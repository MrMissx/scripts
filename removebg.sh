#!usr/bin/bash
# remove any image background with API from remove.bg
# make a file named "rbgapi.ini" and paste your API there


removebg() { 
    curl -H "X-API-Key: $RM_BG_API_KEY" \
        -F "image_file=@{FILE}" \
        -f https://api.remove.bg/v1.0/removebg -o no-bg.png
}

getapi() {
    if ! [[ -e "$(pwd)/rbgapi.ini" ]]; then
		echo -e "No API found"
		echo -e "read the script desc please!"
	    exit 7
    else
        read -r RM_BG_API_KEY < "$(pwd)/rbgapi.ini"
        echo -e $RM_BG_API_KEY
        #while read -r line; do
        #    RM_BG_API_KEY=$line
        #done < "$(pwd)/rbgapi.ini"
	fi

}

getfile() {
    echo -e "Enter your filename: "
    read -r FILENAME
    FILE=${PATH}/$FILENAME
    #check file
    if ! [[ -e $FILE ]]; then
		echo -e "No such file in this directory"
		echo -e "Don't forget the file extension"
		exit 1
	fi
}


getapi
getfile
removebg