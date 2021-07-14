find . -type f -name '*' | while read FILE ; do
    newfile="$(echo ${FILE} |sed -e 's/addicted/aa/')" ;
    mv "${FILE}" "${newfile}" ;
done 
