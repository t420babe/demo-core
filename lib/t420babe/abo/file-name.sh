find . -type f -name '*.glsl' | while read FILE ; do
    newfile="$(echo ${FILE} |sed -e 's/bn/abo/')" ;
    git mv "${FILE}" "${newfile}" ;
done 
