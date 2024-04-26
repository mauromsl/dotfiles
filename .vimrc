set number
set relativenumber
set background=dark
set encoding=utf-8
set incsearch
set hlsearch
set gp=git\ grep\ -n
hi Search ctermbg=LightBlue
syntax on

set splitbelow splitright

"Autocomplete bash-like:
set wildmode=longest,list,full
set wildmenu
set nocompatible              " be iMproved, required
filetype off                  " required


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Install vim-plug if we don't already have it
if empty(glob('~/.vim/autoload/plug.vim'))
silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" HTML and CSS
Plug 'mattn/emmet-vim'
Plug 'ap/vim-css-color'
Plug 'gregsexton/matchtag'

" Go (run :GoInstallBinaries to complete installation)
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" Python
"Plug 'python-mode/python-mode'
"let g:pymode_python = 'python3'
"Plug 'nvie/vim-flake8'

"Autocompletion library (SLOW)
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" General tools
Plug 'junegunn/fzf',
Plug 'mauromsl/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'psliwka/vim-smoothie'

" Extra points for style
Plug 'vim-airline/vim-airline'
Plug 'nordtheme/vim'

call plug#end()

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction


highlight ExtraWhitespace ctermbg=blue guibg=blue
match ExtraWhitespace /\s\+$\|[^ ]  [^ ]/
:autocmd ColorScheme * highlight ExtraWhitespace ctermbg=blue guibg=blue
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab smartindent fileformat=unix
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" File type specific

au FileType python call SetPythonOptions()
function SetPythonOptions()
    set tabstop=4 softtabstop=4 shiftwidth=4 colorcolumn=80 expandtab smartindent fileformat=unix
    " Match bad indent (starts with space AND number of spaces not multiple of 4)
    call matchadd('ExtraWhitespace', '\v^((([ ]{4})+[^ ])@!)(^[ ])@=[ ]*')
    hi MatchParen cterm=bold ctermbg=none ctermfg=magenta
    " python insert pdb
    nnoremap <leader>p oimport pdb; pdb.set_trace()<Esc>
    nnoremap <leader><S-p> Oimport pdb; pdb.set_trace()<Esc>

endfunction
autocmd FileType python let b:coc_root_patterns = ['.git', './src/']

au FileType go call SetGoOptions()
function SetGoOptions()
    set tabstop=4 softtabstop=0 shiftwidth=4 colorcolumn=120 noexpandtab smartindent fileformat=unix
    let g:go_highlight_functions = 1
    let g:go_highlight_function_calls = 1
    let g:go_highlight_extra_types = 1
    let g:go_highlight_operators = 1

    " Auto formatting and importing
    let g:go_fmt_command = "goimports"
    let g:go_metalinter_autosave = 1
endfunction

"autocmd BufWritePre *.go :GoMetaLinter
au BufNewFile,BufRead *.html set tabstop=2 softtabstop=2 shiftwidth=2 expandtab smartindent fileformat=unix nowrap
au BufNewFile,BufRead *.xml set tabstop=2 softtabstop=2 shiftwidth=2 expandtab smartindent fileformat=unix nowrap
au BufNewFile,BufRead *.xsl set tabstop=2 softtabstop=2 shiftwidth=2 expandtab smartindent fileformat=unix nowrap
au BufNewFile,BufRead *.csv set nowrap

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Render Whitespace
set list
set listchars=tab:--,trail:~,extends:>,precedes:<


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Remaps
nnoremap <SPACE> <Nop>
let mapleader=" "

"CoC
nnoremap <silent> <leader>d :call ShowDocumentation()<CR>
inoremap <silent><expr> <tab> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"


inoremap <silent><expr> <leader>d coc#refresh()
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

" Maps CtrlP to FZF
nnoremap <C-p> :FZF<Cr>

colorscheme nord
if $BACKGROUND == 'light'
  set background=light
endif

" *nix avoid clipboard clear on vim exit
autocmd VimLeave * call system("xsel -ib", getreg('+'))

" WSL yank support
let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path to match C drive mountpoint
if executable(s:clip)
    augroup WSLYank
      autocmd!
      autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
    augroup END
endif
