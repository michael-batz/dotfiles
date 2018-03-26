" tabstops
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
retab

" autoindent
set autoindent
set pastetoggle=<F3>

" linenumbers
set number
highlight LineNr ctermfg=darkgrey

" disable search highlighting
set nohlsearch

" syntax highlighting
filetype plugin indent on
syntax on

" colors
set background=dark

" viminfo settings
set viminfo='50,<1000,n~/.viminfo

" statusbar settings
set showcmd

" disable error bells
set noerrorbells visualbell t_vb=

" support for specific file types:
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType yaml setlocal noautoindent nocindent nosmartindent indentexpr=
