find . -type f -name '*.glsl' | while read FILE ; do
    newfile="$(echo ${FILE} |sed -e 's/arrival/bl/')" ;
    git mv "${FILE}" "${newfile}" ;
done 
