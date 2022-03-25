#!/bin/bash

function install_deps() {
    # install dwebp and mogrify utilities from webp and imagemagick, respectively, if not already installed
    sudo apt install -y webp imagemagick
}

function convertWebpToPng() {
    # convert .webp images to .png
    # image.webp becomes image.webp.png
    find . -name "*.webp" -exec dwebp {} -o {}.png \;
}

function convertPngToJpg() {
    # convert .png images to .jpg
    # image.webp.png becomes image.webp.jpg?
    mogrify -format jpg -path . ./*.png
}

function deleteOriginalWebp() {
    # Delete original .webp files
    find . -name "*.webp" -type f -delete
}

function renameWebpToJpg() {
    # Rename .webp.jpg to #.jpg
    for i in *.webp.jpg; do mv "${i}" "${i%.jpg}"; done
}

function runIt() {
    install_deps && \
    convertWebpToPng && \
    convertPngToJpg && \
    deleteOriginalWebp && \
    renameWebpToJpg
}

#runIt

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

convertAllCurrentAndSubDirs