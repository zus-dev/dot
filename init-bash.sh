#!/bin/bash
PROFILE_SYMLINK=~/.profile
PROFILE_FILE=$PWD/bash-profile
if [ -f "$PROFILE_SYMLINK" ]; then
    echo "$PROFILE_SYMLINK exist"
else
    ln -s $PROFILE_FILE $PROFILE_SYMLINK
    echo "$PROFILE_SYMLINK => $PROFILE_FILE"
fi

