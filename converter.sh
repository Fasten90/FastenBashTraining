#!/bin/bash
set -e

#convert 


#nconvert.exe -xall -out jpeg -dpi 100 -o x.jpg a.pdf
XNVIEW_PATH="c:\Programs\Common\XnView\nconvert.exe"
XNVIEW_ARGS="-xall -out jpeg -dpi 300 -o"

#https://www.xpdfreader.com/pdftopng-man.html
XPDF_CONVERTER="C:\Programs\Engineer\xpdf-tools-win-4.03\bin64\pdftopng.exe"
XPDF_ARGS="-alpha"

#BMP fájl legyen
#Mérete pedig ugyanilyen, mint ezeké:
#weight 73 * 44
#Bit depth 4
XNVIEW_BMP_ARGS="-xall -out bmp -dpi 300 -o"


mkdir -p PNG
cd PDF
for f in *.pdf
do
 
	echo "File: $f"
	# always "double quote" $f to avoid problems
    # Does not work:
    #file_basename=basename "$f" .pdf
    #https://stackoverflow.com/questions/965053/extract-filename-and-extension-in-bash
    filename=$(basename -- "$f")
    extension="${filename##*.}"
    filename="${filename%.*}"

    echo "$XPDF_CONVERTER $XPDF_ARGS \"$f\" \"../PNG/$filename\""
    $XPDF_CONVERTER $XPDF_ARGS "$f" "../PNG/$filename"
done


cd ..


sleep 1


cd PNG
for f in *.png
do
    filename=$(basename -- "$f")
    extension="${filename##*.}"
    filename="${filename%.*}"

    echo $XNVIEW_PATH $XNVIEW_ARGS \"../JPG/$filename.jpg\" "$f"
	$XNVIEW_PATH $XNVIEW_ARGS "../JPG/$filename.jpg" "$f"
    
    echo $XNVIEW_PATH $XNVIEW_BMP_ARGS \"../JPG/$filename.jpg\" "$f"
	$XNVIEW_PATH $XNVIEW_BMP_ARGS "../BMP/$filename.bmp" "$f"
done

# TODO: Resize - done by batch convert with xnview
# C:\prg\XnView\nconvert.exe -out jpeg -ratio -resize 1024 0 -rmeta -buildexifthumb -o %_size1024.jpg *.jpg *.jpeg 


# To bmp 4 bits
# https://online-converting.com/image/convert2bmp/
