""" Config
""""""""""
set number
set relativenumber
set background=dark
set encoding=utf-8
set incsearch
set hlsearch
set gp=git\ grep\ -n
syntax on

set splitbelow splitright

"Autocomplete bash-like:
set wildmode=longest,list,full
set wildmenu
set nocompatible              " be iMproved, required
filetype off                  " required

""" Plugins
"""""""""""

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

" LSP
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'

" HTML and CSS
Plug 'mattn/emmet-vim'
Plug 'ap/vim-css-color'
Plug 'gregsexton/matchtag'

" Go (run :GoInstallBinaries to complete installation)
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }


" Files
Plug 'junegunn/fzf'
Plug 'iberianpig/ranger-explorer.vim'

" Editing
Plug 'mauromsl/vim-surround'
Plug 'wellle/context.vim'
Plug 'tpope/vim-commentary'

" Extra points for style
Plug 'vim-airline/vim-airline'
Plug 'nordtheme/vim'
Plug 'psliwka/vim-smoothie'

call plug#end()


""" Style
"""""""""

" :autocmd ColorScheme * highlight ExtraWhitespace ctermbg=blue guibg=blue
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab smartindent fileformat=unix
" File type specific

au FileType python call SetPythonOptions()
function SetPythonOptions()
    set tabstop=4 softtabstop=4 shiftwidth=4 colorcolumn=80 expandtab smartindent fileformat=unix
    " Match bad indent (starts with space AND number of spaces not multiple of 4)
    call matchadd('ExtraWhitespace', '\v^((([ ]{4})+[^ ])@!)(^[ ])@=[ ]*')
    hi MatchParen cterm=bold ctermbg=NONE ctermfg=magenta
    " python insert pdb
    nnoremap <leader>p oimport pdb; pdb.set_trace()<Esc>
    nnoremap <leader><S-p> Oimport pdb; pdb.set_trace()<Esc>

endfunction
au FileType css call SetCSSOptions()
function SetCSSOptions()
    set tabstop=4 softtabstop=4 shiftwidth=4 colorcolumn=80 expandtab smartindent fileformat=unix
    set tabstop=2 softtabstop=2 shiftwidth=2 expandtab smartindent fileformat=unix

endfunction

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


" Render Whitespace
set list
set listchars=tab:--,trail:~,extends:>,precedes:<

""" Remaps
""""""""""

nnoremap <SPACE> <Nop>
" map <Space> <Leader>
let mapleader=" "

"CoC
"xnoremap <silent> <leader>d :call ShowDocumentation()<CR>
" inoremap <silent><expr> <tab> pumvisible() ? coc#pum#confirm() : "\<C-g>u\<tab>"


" inoremap <silent><expr> <leader>d coc#refresh()
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

colorscheme menord
" if $BACKGROUND == 'light'
"   set background=light
" endif
"
" Avoid themes overriding background color/transparency
highlight Normal guibg=NONE
highlight Normal ctermbg=NONE
highlight NonText guibg=NONE
highlight NonText ctermbg=NONE
highlight LspInlayHint ctermbg=gray guibg=gray

" *nix avoid clipboard clear on vim exit
autocmd VimLeave * call system("xsel -ib", getreg('+'))

" WSL yank to clipboard support
let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path to match C drive mountpoint
if executable(s:clip)
    augroup WSLYank
      autocmd!
      autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
    augroup END
endif

" fzf
"let $FZF_DEFAULT_OPTS="--preview 'bat --color=always {}' --color=dark"
let $FZF_DEFAULT_OPTS="--preview 'vimcat {}' --height 40% --tmux bottom,40% --border top"
let g:fzf_vim = {}
let g:fzf_vim.preview_window = ['top,20%', 'ctrl-/']

" ranger
" nnoremap <silent><Leader>n :RangerOpenCurrentFile<CR>
nnoremap <silent><Leader>c :RangerOpenCurrentDir<CR>
nnoremap <C-f> :RangerOpenProjectRootDir<CR>
let g:ranger_explorer_keymap_edit    = '<C-e>'

""" LSP Config
""""""""""""""
" pylsp
"
if executable('pylsp')
    " pip install python-lsp-server
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pylsp',
        \ 'cmd': {server_info->['pylsp']},
        \ 'allowlist': ['python'],
        \ })
endif

" LSP bindings
function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> gh <plug>(lsp-hover)
    nnoremap <buffer> <expr><c-k> lsp#scroll(+4)
    nnoremap <buffer> <expr><c-j> lsp#scroll(-4)


    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')

endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

"autocomplete
let g:asyncomplete_auto_popup = 1
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"
imap <c-space> <Plug>(asyncomplete_force_refresh)

highlight ExtraWhitespace ctermbg=magenta guibg=magenta
if has('nvim')
    " nvim stutters with default presenter
    let g:context_presenter = 'preview'
    " nord theme not picked up by nvim, set explicitely
    highlight ExtraWhitespace guibg='#B48EAD'
else
    " This is annoying without inlay rendering
    let g:lsp_diagnostics_enabled = 0
endif
let g:context_max_height = 0
let g:context_max_per_indent = 0

"
match ExtraWhitespace /\s\+\%#\@<!$/
