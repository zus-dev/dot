## Install SSH
```
pkg upgrade
pkg install openssh
passwd
```

## Install essentials
```
pkg install git
pkg install build-essential
pkg install tmux byobu fzf vim-python nodejs
# TODO: phython-dev is not required?
```

## External storage
Request access to the external storage:
```
termux-setup-storage
```
Important folders:
```
# Environment variable points to root forlder of the termux 
$PREFIX
~/storage
/storage/
/etc
```
