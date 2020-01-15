#!/bin/sh
echo "Install vim configurations..."

echo "cd to .vim directory"
cd ~/.vim

echo "backup origin vimrc..."
if [ -f "$HOME/.vimrc" ]; then
    mv ~/.vimrc ~/.vimrc.`date +%Y%m%d`
fi
    
echo "create new vimrc..."
ln -s ~/.vim/vimrc ~/.vimrc

git submodule init
git submodule update
    
vi +BundleInstall! +qall


echo "link colorschemes"
ln -s ~/.vim/bundle/vim-colorschemes/colors
