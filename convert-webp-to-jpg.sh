#!/bin/bash

function convertAllCurrentDir(){ 
    for i in *.webp; do
        echo "Converting ${i}"

        pngImg="${i%.*}.png"

        echo "Converting webp to png..."
        dwebp "${i}" -o "${pngImg}"
      
        echo "Deleting original webp..."
        rm "${i}" && \
        
        echo "Converting png to jpg..."
        mogrify -format jpg "${pngImg}"

        echo "Deleting png..."
        rm "${pngImg}"
    done
}

function convertAllCurrentAndSubDirs(){ 
    # Make sure globstar is enabled
    shopt -s globstar

    for i in **/*.webp; do
        echo "Converting ${i}"

        pngImg="${i%.*}.png"

        echo "Converting webp to png..."
        dwebp "${i}" -o "${pngImg}"
           
        echo "Deleting original webp..."
        rm "${i}" && \
        
        echo "Converting png to jpg..."
        mogrify -format jpg "${pngImg}"
        
        echo "Deleting png..."
        rm "${pngImg}"
    done
}

# Run it
# convertAllCurrentDir
convertAllCurrentAndSubDirs