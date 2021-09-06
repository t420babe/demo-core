find . -type f -name '*.glsl' | while read FILE ; do
    newfile="$(echo ${FILE} |sed -e 's/fractions/abf/')" ;
    git mv "${FILE}" "${newfile}" ;
done 
