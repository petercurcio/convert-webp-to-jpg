#!/bin/bash

function convertAllCurrentDir(){ 
    for i in *.webp; do
        # echo "starting conversion..."
        echo "Converting ${i}"

        pngImg="${i%.*}.png"

        echo "Converting webp to png..."
        dwebp "${i}" -o "${pngImg}"
        
        # echo "Sleeping 10..." && sleep 10 && \

        echo "Deleting original webp..."
        rm "${i}" && \
        
        # echo "Sleeping 10..." && sleep 10 && \
        
        echo "Converting png to jpg..."
        mogrify -format jpg "${pngImg}"
        
        # echo "Sleeping 10..." && sleep 10 && \
        
        #echo "Renaming png to jpg..." && \
        #mv "${pngImg}" "${i%.*}.jpg" && \

        echo "Deleting png..."
        rm "${pngImg}"

        # echo "Finished converting..."
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