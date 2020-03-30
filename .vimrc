set number
set background=dark
set encoding=utf-8
set hlsearch
hi Search ctermbg='LightBlue'
syntax on

"Autocomplete bash-like:
set wildmode=longest,list,full
set wildmenu
set nocompatible              " be iMproved, required
filetype off                  " required


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" set the runtime path to include Vundle and initialize

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Git
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'

" HTML and CSS
Plugin 'mattn/emmet-vim'
Plugin 'ap/vim-css-color'

" Go (run :GoInstallBinaries to complete installation)
Plugin 'fatih/vim-go'

" Python
Plugin 'python-mode/python-mode'
let g:pymode_python = 'python3'
"Plugin 'nvie/vim-flake8'

"Autocompletion library (SLOW)
Bundle 'Valloric/YouCompleteMe'

Plugin 'ctrlpvim/ctrlp.vim'

Plugin 'vim-airline/vim-airline'
Plugin 'tpope/vim-surround'

call vundle#end()            " required

filetype plugin indent on    " required

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" File type specific

au BufNewFile,BufRead *.py set tabstop=4    softtabstop=4     shiftwidth=4     colorcolumn=80     expandtab     smartindent     fileformat=unix
au BufNewFile,BufRead *.html set tabstop=4    softtabstop=4     shiftwidth=4    expandtab     smartindent     fileformat=unix nowrap
au BufNewFile,BufRead *.csv set nowrap

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Higlight Whitespace

set list

" Highlights all whitespace
set listchars=eol:¬,tab:--,trail:~,extends:>,precedes:<,space:˙

"extra whitespace:

highlight ExtraWhitespace ctermbg=red guibg=red

match ExtraWhitespace /\s\+$/

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Remaps
noremap <Up> <C-y>
noremap <Down> <C-e>
nmap <Left> <<
nmap <Right> >>
vmap <Left> <gv
vmap <Right> >gv
