#!/bin/bash
SYMLINK=~/.tmux.conf
FILE=$PWD/tmux.conf
if [ -f "$SYMLINK" ]; then
    echo "$SYMLINK exist"
else
    ln -s $FILE $SYMLINK
    echo "$SYMLINK => $FILE"
fi

