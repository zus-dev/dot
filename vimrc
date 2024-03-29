" TO RELOAD .vimrc
" :so %

" check for loaded scripts
" :scriptnames

" :help args
" :help argadd
" :help argdelete

" Enable mouse (e.g. for drag-n-drop window borders)
" :help mouse
set mouse=n
" default (no mouse)
" set mouse=""
set ttymouse=xterm2

filetype plugin indent on
" size of the tab
set tabstop=4
" size of indentation
set shiftwidth=4
set expandtab
" https://stackoverflow.com/questions/35156448/autoindent-smartindent-and-indentexpr
" #, the line is automatically reindenting to the very beginning of the line:
" #<-- CURSOR IS HERE
" it's an effect of the smartindent option, so to fix it, I just have to run
" :set nosi (or disable it in my .vimrc).

" Remove Trailing Whitespace on Save
" autocmd BufWritePre * :%s/\s\+$//e

" To get the filetype:
" :set filetype?
autocmd FileType html setlocal shiftwidth=2 tabstop=2
autocmd FileType javascript.jsx setlocal shiftwidth=2 tabstop=2
autocmd FileType dart setlocal shiftwidth=2 tabstop=2
autocmd FileType yaml setlocal shiftwidth=2 tabstop=2
autocmd FileType go setlocal noexpandtab
autocmd FileType c setlocal noexpandtab 
autocmd FileType uxntal setlocal iskeyword+=- iskeyword+=? noexpandtab nosmartindent


" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" try redrawing as fewer times as possible.
set lazyredraw
set ttyfast

" Long lines make VIM slow
set synmaxcol=255

" folding
" anything other than 'syntax'
set foldmethod=indent
" Fix vim to properly indent folds containing Python comment lines
set foldignore=

" Show (partial) command in the last line of the screen.  Set this
" option off if your terminal is slow.
" SEE Below second one!
set showcmd

" list of options for Insert mode completion
" Use the popup menu also when there is only one match.
" preview - opens a preview windows Ctrl-w z to close the preview window
set completeopt=menuone,noinsert,noselect

" Show vertical line
" set colorcolumn=120

" save marks between session (uppercase or numberic)
" more info
" :he 21.3
" :he E20
" :mksession
set viminfo='1000,f1

" make backspace work like most other programs
" :help 'backspace'
set backspace=indent,eol,start

" syntax highlighting
syntax on

" show line numbers
" to turn off:
" set nonumber
" set number!
" set relativenumber
" turn hybrid line numbers on
" :set number relativenumber
" :set nu rnu

" disable word wrap by default
set wrap!

" always show status line
" set laststatus=2
" show filename in the status line
" set statusline+=%F

" BEGIN: Searching

" highlight all search pattern matches
" :nohlsearch
set hlsearch

" Show the next match while entering a search
" Ctrl-L (:help c_CTRL-L) to insert the next character from the match or
" Ctrl-R Ctrl-W (:help c_CTRL-R_CTRL-F) to complete the current matching word.
set incsearch

" Do not wrap around search
" when "search next" reaches end of file, it wraps around to the beginning,
" and when "search previous" reaches the beginning, it wraps around to the end.
set nowrapscan

" Case sensitivity
" When 'ignorecase' and 'smartcase' are both on, if a pattern contains an
" uppercase letter, it is case sensitive, otherwise, it is not. For example,
" /The would find only "The", while /the would find "the" or "The" etc.
set ignorecase
set smartcase

" END: Searching

" Show file options above the command line
" :h 'wildmenu'
set wildmenu
" set wildmode=longest:full,full
set wildmode=longest:list,full
" To make it work recursively with eg :find <filename>
set path+=**

" Show invisible characters
set listchars=tab:→\ ,space:·,nbsp:␣,trail:•,eol:¶,precedes:«,extends:»
" turn on:
" set list

" disable auto indent on paste
" By configuring set paste, you're effectively disabling all mappings and abbreviations.
" You only need that set when you actually paste text in terminal Vim! It's best to bind this to a key.
" set paste

" set auto indentation
set autoindent
set smartindent

" spellcheck
" set spell spelllang=en_us
"      set spellsuggest=fast,20 "Don't show too much suggestion for spell
"      check.
"           set spellfile=~/Dropbox/Tool/Vim_Spell_add/en.utf-8.add
set spell spelllang=en_us
set spellsuggest=fast,20
" NOTE: Below solution is only for text files, for other types it's a bit more tricky
" Don't mark URL-like things as spelling errors
" defining a new syntax highlighting group called UrlNoSpell (could be called
" whatever you want), and when text matches the pattern, we mark it with the
" special highlight group
syn match UrlNoSpell '\w\+:\/\/[^[:space:]]\+' contains=@NoSpell
" Don't count acronyms / abbreviations as spelling errors
" (all upper-case letters, at least three characters)
" Also will not count acronym with 's' at the end a spelling error
" Also will not count numbers that are part of this
" Recognizes the following as correct:
syn match AcronymNoSpell '\<\(\u\|\d\)\{3,}s\?\>' contains=@NoSpell
" turn off by default
set nospell

" syntax highlight for markdown, set to .markdown by default.
" set syntax=markdown
au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown
" Highlight syntax inside Markdown
let g:markdown_fenced_languages = ['html', 'python', 'vim', 'c']

" syntax highlight for QuakeC 
au BufNewFile,BufFilePre,BufRead *.qc set filetype=quakec


" Highlight current line (horizontal line)
" See hi CursorLine below
" set cursorline
augroup CursorLine
  au!
  autocmd VimEnter,WinEnter,BufWinEnter,FocusGained,CmdwinEnter,InsertLeave * setlocal cursorline
  autocmd WinLeave,FocusLost,CmdwinLeave,InsertEnter * setlocal nocursorline
augroup END

" logs highlight
" autocmd BufNewFile,BufReadPost *messages* :set filetype=messages
" :set filetype=messages

" turn off autoindent when you paste code, there's a special 'paste' mode
" :set paste
" :set nopaste
" set pastetoggle=<F3>


" word wrapping
":set wrap!
":set nowrap

"  " BEGIN: Color Scheme
"  " list of colors:
"  " :h cterm-colors
"  " list of types to highlight:
"  " :hi
"  " hi CursorLine cterm=NONE ctermbg=darkgray ctermfg=white guibg=darkgray guifg=white
"  hi CursorLine cterm=NONE ctermbg=0 guibg=lightgray
"  hi Search cterm=NONE ctermfg=black ctermbg=yellow
"  hi String cterm=NONE ctermfg=brown
"  " hi String cterm=NONE ctermfg=4
"  hi Keyword cterm=NONE ctermfg=blue
"  hi Statement cterm=NONE ctermfg=blue
"  hi Type cterm=NONE ctermfg=blue
"  " hi DiffAdd cterm=NONE ctermfg=black ctermbg=LightBlue
hi DiffAdd cterm=NONE ctermfg=white ctermbg=green
hi DiffDelete cterm=NONE ctermfg=white ctermbg=red
hi DiffChange cterm=NONE ctermfg=white ctermbg=LightMagenta
hi DiffText cterm=NONE ctermfg=white
"  " hi Function cterm=NONE ctermfg=blue
"  " hi Function cterm=NONE ctermfg=5
"  " hi Function cterm=NONE ctermfg=white
"  " hi Function cterm=NONE ctermfg=lightgreen
"  hi Function cterm=NONE ctermfg=darkgreen
"  hi Constant cterm=NONE ctermfg=blue
"  hi SpellBad cterm=NONE ctermfg=black
 hi Folded cterm=NONE ctermfg=gray ctermbg=none
"  " hi ColorColumn ctermbg=8
"  hi ColorColumn ctermbg=6
"  hi Comment cterm=NONE ctermfg=gray
"  hi Visual cterm=NONE ctermfg=black ctermbg=white
"  " LSClient uses this for Linter
"  hi SpellCap cterm=NONE ctermfg=white ctermbg=brown
"  
"  " END: Color Scheme

" completion using a syntax file
" enable omni completion using a syntax file:
" setlocal omnifunc=syntaxcomplete#Complete
" enable omni if it is not set yet:
" if has("autocmd") && exists("+omnifunc")
"   autocmd Filetype *
"           \ if &omnifunc == "" |
"           \     setlocal omnifunc=syntaxcomplete#Complete |
"           \ endif
" endif

" BEGIN: Vundle
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
"OFF: Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"OFF: Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"OFF: Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" YouCompleteMe
" Plugin 'Valloric/YouCompleteMe'

" Cheat sheet
"Plugin 'dbeniamine/cheat.sh-vim'

" FZF
" for :Ag you need to install the_silver_searcher
" https://github.com/ggreer/the_silver_searcher
" example of fzf based vimrc
" https://github.com/junegunn/dotfiles/blob/master/vimrc
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'

" Switch .h => .cpp (doesn't work for different include and src locations)
" Plugin 'derekwyatt/vim-fswitch'

" Insert or delete brackets, parens, quotes in pair.
" Plugin 'jiangmiao/auto-pairs'

" The enhanced C++ syntax highlighting.
" Plugin 'octol/vim-cpp-enhanced-highlight'

" tagbar
Plugin 'majutsushi/tagbar'

" Switch between different file projections (alternatives e.g. *.h => *.cpp)
" Plugin 'tpope/vim-projectionist'

" press "-" to open the file location for the current buffer (NERDTree will do
" the same)
" Plugin 'tpope/vim-vinegar'

Plugin 'Konfekt/FastFold'

" CMake helper
" Plugin 'vhdirk/vim-cmake'

" The NERDTree
Plugin 'scrooloose/nerdtree'

" Vastly improved Javascript indentation and syntax support in Vim.
" Plugin 'pangloss/vim-javascript'

" quickly and easily switch between buffers
" Plugin 'jlanzarotta/bufexplorer'

" Python IDE
" Plugin 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }

" Complementary pairs of mappings
Plugin 'tpope/vim-unimpaired'

" GitGutter
" Plugin 'airblade/vim-gitgutter'

" Dart language support
" Plugin 'dart-lang/dart-vim-plugin'

" LSC Language Server Protocol (LSP) Client (e.g used for Dart)
" Plugin 'natebosch/vim-lsc'

" Dart configuration for the LSP (fails with 'Invalid file path')
" Plugin 'natebosch/vim-lsc-dart'

" vim-go golang language support
" You will also need to install all the necessary binaries. vim-go makes it
" easy to install all of them by providing a command, :GoInstallBinaries,
" which will go get all the required binaries.
"
" Check out the Install section in the documentation for more detailed
" instructions (:help go-install).
"
" The full documentation can be found at doc/vim-go.txt. You can display it
" from within Vim with :help vim-go.
Plugin 'fatih/vim-go'

" ALE Check syntax in Vim asynchronously and fix files, with LSP support
" This is alternative to vim-lsc
" You may also consider combining package:dart_language_server with a Language
" Server Protocol client, like ale.
" Plugin 'dense-analysis/ale'

" Viewer & Finder for LSP symbols and tags
" Plugin 'liuchengxu/vista.vim'

" Fast and featureful file manager in vim/neovim powered by nnn
" Plugin 'mcchrish/nnn.vim'

" This plugin automatically adjusts 'shiftwidth' and 'expandtab' heuristically
" based on the current file, or, in the case the current file is new, blank,
" or otherwise insufficient, by looking at other files of the same type in the
" current and parent directories. In lieu of adjusting 'softtabstop',
" 'smarttab' is enabled.
" NOTE: this think doesn't guess properly e.g. for new file. Messing with
" default settings. Disabling it.
" Plugin 'tpope/vim-sleuth'

" This plugin formats your code with specific coding style using clang-format.
" :Clang*
Plugin 'rhysd/vim-clang-format'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
" END: Vundle

" Vundle overrides this so this needs to be restored afterwards
set showcmd

" vim-go config
" auto close folds issue:
" https://github.com/fatih/vim-go/issues/502
"
" One work-around to avoid this issue is to disable GoFmt: let
" g:go_fmt_autosave = 0
" You can then run GoFmt manually at specific times via :GoFmt in vim (but you
" still loose all folds at this point).
" let g:go_fmt_autosave = 0
"
" don't auto close folds on write:
let g:go_fmt_experimental = 1

" " Vista config
" " See :help vista-options for more information.
" let g:vista_icon_indent = ["▸ ", ""]
" " Executive used when opening vista sidebar without specifying it.
" " See all the avaliable executives via `:echo g:vista#executives`.
" " let g:vista_default_executive = 'vim_lsc'
" let g:vista_executive_for = {
"   \ 'dart': 'vim_lsc',
"   \ }
" " To enable fzf's preview window set g:vista_fzf_preview.
" " The elements of g:vista_fzf_preview will be passed as arguments to fzf#vim#with_preview()
" " For example:
" let g:vista_fzf_preview = ['right:50%']
" " Ensure you have installed some decent font to show these pretty symbols, then you can enable icon for the kind.
" let g:vista#renderer#enable_icon = 0

" LSC config
" The Dart SDK comes with an analysis server that can be run in LSP mode.
" Make sure dart added to the $PATH
" bash: $(dirname $(which dart))
let g:dart = resolve(exepath('dart'))
let g:lsc_server_commands = {'dart': 'dart '.fnamemodify(g:dart, ':h').'/snapshots/analysis_server.dart.snapshot --lsp'}
" Set complete default mappings (for the list see doc or github page)
let g:lsc_auto_map = v:true
let g:lsc_reference_highlights = v:false

" Pymode config
let g:pymode_rope = 1
let g:pymode_rope_goto_definition_bind='<Leader>rg'
let g:pymode_rope_rename_bind = '<Leader>rr'
let g:pymode_run_bind = '<leader>rR'
let g:pymode_rope_show_doc_bind = '<Leader>rd'
let g:pymode_breakpoint_bind = '<leader>rb'
" let g:pymode_python = 'python'

" YouCompleteMe config
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
" let g:ycm_min_num_of_chars_for_completion = 3
" let g:ycm_min_num_identifier_candidate_chars = 2
" let g:ycm_add_preview_to_completeopt = 1
let g:ycm_auto_trigger = 1
" let g:ycm_server_python_interpreter='/usr/bin/python'
let g:ycm_show_diagnostics_ui = 0

" Sessions
" :mksession ~/.vim/sessions/my-session.vim
" :source ~/.vim/sessions/my-session.vim
" When the cycle repeats as you rearrange the furniture, just overwite the old  session by using
" :mks!

" NERDTree file filters
" let NERDTreeIgnore=['.git$[[dir]]', '.swp']
" let NERDTreeIgnore=['.cpp']

" Persistent folds
" :h viewdir
"augroup AutoSaveFolds
"    autocmd!
"    autocmd BufWinLeave * mkview
"    autocmd BufWinEnter * silent! loadview
"augroup END

fun! ToggleCC()
  if &filetype == 'python'
      return
  endif

  if &cc == ''
    set colorcolumn=120
  else
    set colorcolumn=
  endif
endfun

function! PasteFromClipboard()
    set paste
    startinsert
endfunction

function! GFilesFallback_BAD()
  let output = system('git rev-parse --show-toplevel') " Is there a faster way?
  let prefix = get(g:, 'fzf_command_prefix', '')
  if v:shell_error == 0
    exec "normal :" . prefix . "GFiles\<CR>"
  else
    exec "normal :" . prefix . "Files\<CR>"
  endif
  return 0
endfunction

" If git directory, use `git ls-files` as source, else fallback to vanilla fzf
function! GFilesFallback()
  let prefix = get(g:, 'fzf_command_prefix', '')
  let output = system('git rev-parse --is-inside-work-tree')
  if output =~ 'true'
    exec "normal :" . prefix . "GFiles\<CR>"
  else
    exec "normal :" . prefix . "Files\<CR>"
  endif
  return 0
endfunction

" Open Ag with GIT root
function! s:with_git_root()
  let root = systemlist('git rev-parse --show-toplevel')[0]
  return v:shell_error ? {} : {'dir': root}
endfunction

let g:fzf_layout = { 'down': '~40%' }
command! -nargs=* Rag
  \ call fzf#vim#ag(<q-args>, extend(s:with_git_root(), g:fzf_layout))

":Ag  - Start fzf with hidden preview window that can be enabled with "?" key
":Ag! - Start fzf in fullscreen and display the preview window above
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)

" Disable nopaste after leave insert mode
autocmd InsertLeave * set nopaste

function! ToggleW()
  set list! spell! wrap!
  call ToggleCC()
endfunction

" Remove Trailing Whitespaces
function! StripTrailingWhitespaces()
  %s/\s\+$//e
endfunction

let mapleader=' '
let maplocalleader=' '
imap jk <Esc>
map <Leader>p :call PasteFromClipboard()<CR>
map <Leader>w :call ToggleW()<CR>

" search in selection
" by using the \%V atom
" press Alt-/ in order to automatically fill in a 'range' for your search
"  When you have selected the area you want to search, press Alt-/. The visual
"  selection will be removed, and a search command will start. You will see:
"  /\%V
vnoremap <Leader>/ <Esc>/\%V

" vim-projectionist
noremap <silent> <Leader>aa         :A<CR>
" navigating quickfix window
noremap <silent> <Leader>.          :cnext<CR>
noremap <silent> <Leader>,          :cprevious<CR>

" FZF
nnoremap <c-p> :call GFilesFallback()<CR>
" nnoremap <silent> <expr> <Leader><Leader> (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":Files\<cr>"
nnoremap <silent> <expr> <Leader><Leader> (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":call GFilesFallback()<CR>"
nnoremap <silent> <Leader><Enter>  :Buffers<CR>
nnoremap <silent> <Leader>l        :BLines<CR>
nnoremap <silent> <Leader>L        :Lines<CR>
nnoremap <silent> <Leader>ag       :Ag <C-R><C-W><CR>
nnoremap <silent> <Leader>AG       :Ag <C-R><C-A><CR>
nnoremap <silent> <Leader>`        :Marks<CR>
nnoremap <silent> <Leader>o        :History<CR>
nnoremap <silent> <Leader>t        :BTags<CR>
nnoremap <silent> <Leader>T        :TagbarOpenAutoClose<CR>
nnoremap <silent> <Leader>nn       :NERDTreeToggle<CR>
nnoremap <silent> <Leader>nf       :NERDTreeFind<CR>

" autocmd InsertEnter * setlocal nocursorline
" autocmd InsertLeave * setlocal cursorline
" autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
" autocmd WinLeave * setlocal nocursorline
" autocmd FocusLost * setlocal nocursorline
" autocmd FocusGained * setlocal cursorline

let g:vitality_tmux_can_focus = 1

