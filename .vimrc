set number
set relativenumber
set background=dark
set encoding=utf-8
set incsearch
set hlsearch
hi Search ctermbg=LightBlue
syntax on

set splitbelow splitright

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

" Ctags
Plugin 'taglist.vim'

" Git
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'

" HTML and CSS
Plugin 'mattn/emmet-vim'
Plugin 'ap/vim-css-color'
Plugin 'gregsexton/matchtag'

" Go (run :GoInstallBinaries to complete installation)
Plugin 'fatih/vim-go'

" Python
"Plugin 'python-mode/python-mode'
"let g:pymode_python = 'python3'
"Plugin 'nvie/vim-flake8'

"Autocompletion library (SLOW)
Bundle 'neoclide/coc.nvim'

" General tools
Plugin 'ctrlpvim/ctrlp.vim'
let g:ctrlp_max_depth=30
let g:ctrlp_max_files=0
Plugin 'jiangmiao/auto-pairs'
Plugin 'mauromsl/vim-surround'
Plugin 'tpope/vim-commentary'
Plugin 'psliwka/vim-smoothie'

" Extra points for style
Plugin 'vim-airline/vim-airline'
Plugin 'arcticicestudio/nord-vim'

call vundle#end()            " required

filetype plugin indent on    " required

highlight ExtraWhitespace ctermbg=blue guibg=blue
match ExtraWhitespace /\s\+$\|[^ ]  [^ ]/
:autocmd ColorScheme * highlight ExtraWhitespace ctermbg=blue guibg=blue
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" File type specific

au FileType python call SetPythonOptions()
function SetPythonOptions()
    set tabstop=4 softtabstop=4 shiftwidth=4 colorcolumn=80 expandtab smartindent fileformat=unix
    " Match bad indent (starts with space AND number of spaces not multiple of 4)
    call matchadd('ExtraWhitespace', '\v^((([ ]{4})+[^ ])@!)(^[ ])@=[ ]*')
    hi MatchParen cterm=bold ctermbg=none ctermfg=magenta
endfunction
autocmd FileType python let b:coc_root_patterns = ['.git', './src/']

au BufNewFile,BufRead *.html set tabstop=4 softtabstop=4 shiftwidth=4 expandtab smartindent fileformat=unix nowrap
au BufNewFile,BufRead *.xml set tabstop=4 softtabstop=4 shiftwidth=4 expandtab smartindent fileformat=unix nowrap
au BufNewFile,BufRead *.csv set nowrap

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Render Whitespace
set list
set listchars=tab:--,trail:~,extends:>,precedes:<


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Remaps
noremap <Up> <C-y>
noremap <Down> <C-e>
noremap <C-j> <C-d>
noremap <C-k> <C-u>
nmap <Left> <<
nmap <Right> >>
nmap s <Plug>Ysurround
vmap <Left> <gv
vmap <Right> >gv
" Chords are for piano
nnoremap ; :
" Escape stops hlsearch
nnoremap <esc> :noh<return><esc>
nnoremap <esc>^[ <esc>^[

colorscheme nord
if $BACKGROUND == 'light'
  set background=light
endif

" WSL yank support
let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path to match C drive mountpoint
if executable(s:clip)
    augroup WSLYank
      autocmd!
      autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
    augroup END
endif
