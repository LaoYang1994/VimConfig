#!/bin/sh
echo "Install vim configurations..."

echo "Install Plug"
if [ ! -d "$HOME/.vim/autoload" ]; then
    echo "mkdir autoload"
    mkdir ~/.vim/autoload
fi
cd ~/.vim/autoload
if [ ! -f "./plug.vim" ]; then
    echo "download plug"
    wget https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

echo "cd to .vim directory"
cd ~/.vim

echo "backup origin vimrc..."
if [ -f "$HOME/.vimrc" ]; then
    if [ ! -L "$HOME/.vimrc" ]; then
        mv ~/.vimrc ~/.vimrc.`date +%Y%m%d`
    else
        echo ".vimrc is a softlink file, delete!"
        rm ~/.vimrc
    fi
fi
    
echo "create new vimrc..."
ln -s ~/.vim/vimrc ~/.vimrc

# git submodule init
# git submodule update
    
vim +PlugInstall +qall

echo "link colorschemes"
if [ ! -d "./colors" ]; then
    ln -s ~/.vim/plugged/vim-colorschemes/colors
fi

