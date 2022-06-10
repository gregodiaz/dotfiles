set number
set mouse=a
set numberwidth=1
set clipboard=unnamed
syntax enable
set showcmd
set ruler
set cursorline
set encoding=utf-8
set showmatch
set sw=2
set relativenumber
set laststatus=2
" set noshowmode

" ----------------------------------------
call plug#begin(stdpath('data') . '/plugged')


 " Temas
Plug 'morhetz/gruvbox'

 " IDE
Plug 'scrooloose/nerdtree'
Plug 'easymotion/vim-easymotion'
Plug 'christoomey/vim-tmux-navigator'

Plug 'jelera/vim-javascript-syntax'

Plug 'maxmellon/vim-jsx-pretty'
" Recomenmended but noy requeried for vim-jsx-pretty
Plug 'yuezk/vim-js'
Plug 'maxmellon/vim-jsx-pretty'
" Highlight tsx files for vim-jsx-pretty
Plug 'HerringtonDarkholme/yats.vim'
" or Plug 'leafgarland/typescript-vim'
Plug 'maxmellon/vim-jsx-pretty'

" json
Plug 'elzr/vim-json'

" Tags HTML, CSS y etc
Plug 'mattn/emmet-vim'

" autocomplete
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
let g:deoplete#enable_at_startup = 1

Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }

Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()
" ----------------------------------------

execute pathogen#infect()
syntax on
filetype plugin indent on

" colorscheme gruvbox
" let g:gruvbox_contrast_dark = "hard"
colorscheme monokai

let mapleader=" "
let NERDTreeQuitOnOpen=1

nmap <Leader>s <Plug>(easymotion-s2)
nmap <Leader>nt :NERDTreeFind<CR>
nmap <Leader>q :q<CR>
nmap <Leader>w :w<CR>
nmap <Leader>x :x<CR>
nmap <Leader>n :noh<CR>
