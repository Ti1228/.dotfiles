#!/bin/bash

# for mac (except mothership).
# Mendeley Onedrive sync.
# Please turn on "Organize my files" option, and set "Copy files to" directory to the directory on Onedrive. (Mendeley Desktop > Preferences > File Organizer)

cd ~/Library/Application\ Support
cp -rf Mendeley\ Desktop/ _backup_Mendeley_Desktop/
rm -rf Mendeley\ Desktop/
ln -snfv ~/Onedrive/Mendeley/db/Mendeley\ Desktop .

