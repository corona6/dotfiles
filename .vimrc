set nocompatible
filetype off

set rtp+=~/dotfiles/.vim/bundle/vundle
call vundle#rc()

Bundle 'git://github.com/Shougo/unite.vim.git'
Bundle 'git://github.com/tpope/vim-fugitive.git'

filetype plugin indent on

set autoindent
syntax on
set mouse=a
set ttymouse=xterm2
set title
set encoding=utf-8
set fileencoding=utf-8
set nobackup
set noswapfile
