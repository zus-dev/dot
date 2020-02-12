#!/bin/bash
SYMLINK=~/.config/i3/config
FILE=$PWD/i3.config
if [ -f "$SYMLINK" ]; then
    echo "$SYMLINK exist"
else
    ln -s $FILE $SYMLINK
    echo "$SYMLINK => $FILE"
fi

