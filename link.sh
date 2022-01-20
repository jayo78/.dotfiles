#!/bin/bash

links=( ".zshrc" ".vimrc" )

for link in "${links[@]}"
do
    echo "linking $link..."
    ln -fs $(pwd)/$link ~/$link
done
    

