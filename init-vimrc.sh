#!/bin/bash
# TODO: check prerequisites - git, cmake, python-dev
VIMRC_FILE=~/.vimrc
VIMRC_DOT_FILE=./vimrc
if [ -f "$VIMRC_FILE" ]; then 
    echo "$VIMRC_FILE exist"
else
    ln -s ~/dot/vimrc ~/.vimrc
    echo "$VIMRC_FILE => $VIMRC_DOT_FILE"
fi

VUNDLE_DIR=~/.vim/bundle/Vundle.vim
if [ -d "$VUNDLE_DIR" ]; then
    echo "$VUNDLE_DIR exist"
else
    git clone https://github.com/VundleVim/Vundle.vim.git $VUNDLE_DIR
    vim +PluginInstall +qall
    ~/.vim/bundle/YouCompleteMe/install.py --ts-completer
fi
