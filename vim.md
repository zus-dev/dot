
## Search and replace 
[More](http://vim.wikia.com/wiki/Search_and_replace)

```vim
" Substitute each 'foo' to 'bar' in the current line.
:s/foo/bar/g

" Substitute each 'foo' to 'bar', but ask for confirmation first.
:%s/foo/bar/gc

" Substitute only whole words exactly matching 'foo' to 'bar'; ask for confirmation.
:%s/\<foo\>/bar/gc

" Substitute each 'foo' (case insensitive due to the i flag) to 'bar'; ask for confirmation.
:%s/foo/bar/gci

" Substitute each 'foo' (case sensitive due to the I flag) to 'bar'; ask for confirmation.
:%s/foo/bar/gcI
```


## Column edit mode 
- Ctrl + V to go into column mode
- Select the columns and rows where you want to enter your text
- Shift + i to go into insert mode in column mode
- Type in the text you want to enter. Dont be discouraged by the fact that only the first row is changed.
- Esc to apply your change (or alternately Ctrl+c)


# Horizontal scroll
```vim
:help scroll-horizontal

map <C-L> 20zl " Scroll 20 characters to the right
map <C-H> 20zh " Scroll 20 characters to the left

zH, zL " Scroll half screenwidth
```


# Autocompletion
```
:h ins-completion
current file: i_CTRL_X_CTRL_N
```

# Open tag in new window
```
C-w C-] C-w T

Then you can also map that:
:nnoremap <silent><Leader><C-]> <C-w><C-]><C-w>T
open tags in preview (:ptag) with e.g. C-w}. Just mentioning it in case...
```

# Split windows:
```
http://vim.wikia.com/wiki/Resize_splits_more_quickly

:split
:vsplit 
:resize NUMBER
:res + NUMBER
:res - NUMBER
:vertical resize NUMBER
:vertical resize + NUMBER
:vertical resize - NUMBER

C-w + hjkl navigating 
C-w } open tag in preview
C-w T open window as tab

#size manipulation even, max height, max width
Ctrl-w = 
Ctrl-w _
Ctrl-w |

# increase decrease height/width
Ctrl-w NUMBER +
Ctrl-w NUMBER -
Ctrl-w NUMBER > 
Ctrl-w NUMBER < 

Ctrl-w r rotate windows
Ctrl-w x swap windows
```


# Go to definition using g
```
gd will take you to the local declaration.
gD will take you to the global declaration.
g* search for the word under the cursor (like *, but g* on 'rain' will find words like 'rainbow').
g# same as g* but in backward direction.
gg goes to the first line in the buffer (or provide a count before the command for a specific line).
G goes to the last line (or provide a count before the command for a specific line).

gf will go to the file under the cursor
g] and other commands will jump to a tag definition
```


# see the full path of the current file
```
1 Ctrl-g
Ctrl-g
```


# avoid escape 
```
Ctrl-[ 
Ctrl-c 
:help i_CTRL-C
```

# comment multiple lines
```
1. First, go to the first line you want to comment, press Ctrl-v. This will put the editor in the VISUAL BLOCK mode.
2. Then using the arrow key and select until the last line
3. Now press Shift-i, which will put the editor in INSERT mode and then press #. This will add a hash to the first line.
4. Then press Esc (give it a second), and it will insert a # character on all other selected lines
```

# Fugitive
## Misk 
cc - commit create
ca - commit amend

## How can I get the commit message when using Gblame?
With your cursor on the commit "gutter", just press o
Try K too.

## How to reblame with the Parent commit?
P

# How to keep cursor horizontal position while scrolling?
:set virtualedit=all

# How to switch your current windows from horizontal split to vertical split and vice versa 
To change two vertically split windows to horizonally split
Ctrl-w t Ctrl-w K
Horizontally to vertically:
Ctrl-w t Ctrl-w H
Explanations:
Ctrl-w t makes the first (topleft) window current Ctrl-w K moves the current window to full-width at the very top Ctrl-w H moves the current window to full-height at far left

# How to jump between hunks:
jump to next hunk (change): ]c
jump to previous hunk (change): [c.


# How to install vim from sources
./configure --with-features=huge --enable-python3interp=yes --enable-fail-if-missing
sudo make install

# How do you use quickfix feature?
:copen " Open the quickfix window
:ccl   " Close it
:cw    " Open it if there are "errors", close it otherwise (some people prefer this)
:cn    " Go to the next error in the window
:cp    " Go to the previous error in the window
:cnf   " Go to the first error in the next file

# How do you use local list feature?
:lopen to open window containing error/warning lines
:lnext to jump to next error/warning
:lprev to jump to previous error/warning

# Moving to matching braces
% key


# GitGutter
<Leader>hp  " preview the hunk


# Open terminal window
:term
Ctrl+N - Switch to the Terminal Normal mode
