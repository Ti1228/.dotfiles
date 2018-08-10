#!/bin/bash

# for mac mothership.
# Mendeley Onedrive sync.
# Please turn on "Organize my files" option, and set "Copy files to" directory to the directory on Onedrive. (Mendeley Desktop > Preferences > File Organizer)

cd ~/Library/Application\ Support
cp -rf Mendeley\ Desktop/ ~/Onedrive/Mendeley/db/
cp -rf Mendeley\ Desktop/ _backup_Mendeley_Desktop/
rm -rf Mendeley\ Desktop/
ln -snfv ~/Onedrive/Mendeley/db/Mendeley\ Desktop .
mkdir -p ~/Onedrive/Mendeley/db/Mendeley\ Desktop

