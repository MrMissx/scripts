#!/usr/bin/bash
#convert your pdf to png file
#poppler-utils or poppler needed

# Check dependencies
if ! command pdftoppm -v &> /dev/null
then
	echo "poppler-utils is not instaled."
	echo ""
	# promt to install
	echo "do you want to install(y/n):"
	read ans
	if [[ "$ans" == "y" ]]; then
		if [ "$(command -v apt-get)" != "" ]; then # debian
			apt-get install poppler-utils
		elif [ "$(command -v pacman)" != "" ]; then # arch
			pacman -S poppler
		else
			echo "Distro not suported"
			echo "install poppler-utils yourself "
			exit 127
		fi
	else
		echo -e "Ok...\nExiting"
		exit 1
	fi
fi

filetoconv() {
	echo -ne "Enter the pdf file name: "
	read PDF
	echo -e ""
	# exit if no file detected
	if ! [[ -e $(pwd)/${PDF} ]]; then
		echo -e "No such file in this directory"
		echo -e "Don't forget the file extension"
		exit 1
	fi
}

outname() {
	echo -ne "Enter the output name: "
	read NAME
	echo -e ""
	echo -ne "Enter the output file (png or jpeg): "
	read EXT
	echo -e ""
}

paging() {
	echo -e "Select the file page to convert"
	echo -e "(leave it blank to convert all pages)"
	echo -ne "Enter here: " 
	read HAL
	echo -e ""
	if [ -z "$HAL" ]; then
		PAGE=""
	else
		PAGE="-f ${HAL} -singlefile"
	fi
}

filetoconv
paging
outname
pdftoppm ${PDF} ${NAME} -${EXT} ${PAGE}
echo -e "Done..."
exit
