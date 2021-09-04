" Create needed folders first
silent !mkdir /root/.vim > /dev/null 2>&1 
silent !mkdir /root/.vim/undodir > /dev/null 2>&1 
silent !mkdir /root/.vim/backup > /dev/null 2>&1 
silent !mkdir /root/.vim/swp > /dev/null 2>&1 

"  Enable syntax highlighting
syntax on
syntax enable

" Autoload a file if was updated outside vim
set autoread

" Add a | character at the start of tab indentation
set list lcs=tab:\|\ 

" Enable line numbers
set number
set relativenumber
set numberwidth=1

" Display line and column number
set ruler

" Search settings
" show matches while searching
" search ignore case by default, case sensitive if the searched word start
" with an uppercase
" remove highlight after a search operation
set ignorecase
set smartcase

" Paste and yank settings
" to allow yank and paste the selection whiout prepending "* to commands
set clipboard=unnamed

" Show the las command used in the bar
set showcmd

" Show related open or closed bracked
set showmatch

" Utf-8 coding to represent characters and also to encode a file
set encoding=utf-8
set fileencoding=utf-8

" Undo settings
" Maintain undo history between sessions
if has('persistent_undo')
	set undofile
endif
set undodir=/root/.vim/undodir//

" Backup
" Backup directory
" Delete backup if vim has succes writing the file
set backupdir=/root/.vim/backup//
set nobackup

" Swap directory
set directory=/root/.vim/swp//

" Unsaved buffers will be hidden
set hidden

" Scrolling after x rows of top and bottom
set scrolloff=8

" Filetype settings to detect filetypes, indentation and also plugins are enable to allow custom
" settings for each filetype
filetype on
filetype indent on
filetype plugin on

" Backspace settings
" Allow backspace to delete indentation and inserted text
" indent - to delete indentation
" eol - to delete line breaks
" start - to delete the start of insert
set backspace=indent,eol,start

" Increase the command line area
set cmdheight=2

" Timeout to execute the command when you stop typing
set updatetime=300

" To hide user define completion message
set shortmess+=c 

" Bell
set noerrorbells

" No wrap text
set nowrap

" Show cursor as block
set guicursor=

" Map Leader
nnoremap <Space> <Nop>
let mapleader=" "

" Mappings

" Alternatives to <Esc>
:inoremap jj <Esc>

" Save and quit buffer
:nnoremap <Leader>w :w<CR>
:nnoremap <Leader>q :q<CR>
:nnoremap <Leader>wq :wq<CR>

" Buffers navigation
:nnoremap <C-h> <C-w>h
:nnoremap <C-j> <C-w>j
:nnoremap <C-k> <C-w>k
:nnoremap <C-l> <C-w>l

" NerdTree Settings
" Quit NerdTree when opening a file
let NERDTreeQuitOnOpen = 1

" Press enter to remove highlight after a search operation
:nnoremap <CR> :nohlsearch<CR><CR>

" NerdTree Mappings
nnoremap <Leader>n :NERDTreeMirror<CR>:NERDTreeFocus<CR>

" Gruvbox settings
" support true color
set termguicolors
set bg=dark
let g:gruvbox_italic=1
let g:gruvbox_contrast_dark='hard'

" Airline settings
let g:airline_powerline_fonts=1

" FZF
"let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8} }
let $FZF_DEFAULT_OPTS='--reverse'

" Godot
func! GodotSettings() abort
	setlocal foldmethod=expr
	" Tab settings
	" tabstop to show existing tabs with 4 spaces width
	" softwidth - when indenting with '>', use 4 spaces widt
	" softtabstop - control <tab> and <bs> keys to match tabstop
	" smartindent will take into account the previous indentation
	setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4 smartindent
	nnoremap <buffer> <F4> :GodotRunLast<CR>
	nnoremap <buffer> <F5> :GodotRun<CR>
	nnoremap <buffer> <F6> :GodotRunCurrent<CR>
	nnoremap <buffer> <F7> :GodotRunFZF<CR>
endfunc
augroup godot | au!
	au FileType gdscript call GodotSettings()
augroup end


" -- Plugins -- 
if empty(glob('/root/.vim/autoload/plug.vim'))
  silent execute '!curl -fLo /root/.vim/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin('/root/.vim/plugged')

Plug 'tpope/vim-commentary' " to comment or uncomment text
Plug 'morhetz/gruvbox' " to manage the appearancae of vim
Plug 'vim-airline/vim-airline' " to see information about the context (status line)
Plug 'vim-airline/vim-airline-themes' " to change the theme of airline
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim' " to search files
Plug 'preservim/nerdtree' " to view the files tree
Plug 'tpope/vim-fugitive' " to manage git commands
Plug 'tpope/vim-surround' " to surround or chante the surround of a text e.g: () to []
Plug 'stsewd/fzf-checkout.vim' " to checkout another branch or tag
Plug 'simeji/winresizer' " to manage size and locations of buffers
Plug 'airblade/vim-gitgutter' " show git diff on lines, manage hunk, etc
Plug 'easymotion/vim-easymotion' " cursor moves smoothly
Plug 'wincent/scalpel' " search and replace
Plug 'ryanoasis/vim-devicons' " nerd font icons on nerd tree and other plugins
Plug 'habamax/vim-godot' " to develop godot apps
call plug#end()

