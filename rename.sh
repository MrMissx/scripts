#!/usr/bin/bash 

echo -e "This is only a rename script!!"
echo -e "All the file must been sort alphabeticaly first"
echo -e ""
echo -ne "Enter the filename (*default is none): "
read -r filename

echo -ne "Enter the initial file number (*default is 0): "
read -r num

echo -ne "enter the file type(eg: .png, .jpg): "
read -r filetype

if [ "$num" ]; then
  a=$num
else
  a=0
fi

for i in *$filetype; do
  new=$(printf "${filename}%03d${filetype}" "${a}") #03 pad to length of 3
  mv -i -- "$i" "$new"
  ((a=a+1))
done