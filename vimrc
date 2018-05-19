if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
   set fileencodings=ucs-bom,utf-8,latin1
endif

set nocompatible	" Use Vim defaults (much better!)
set bs=indent,eol,start		" allow backspacing over everything in insert mode
"set ai			" always set autoindenting on
"set backup		" keep a backup file
set viminfo='20,\"50	" read/write a .viminfo file, don't store more
			" than 50 lines of registers
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time

" Only do this part when compiled with support for autocommands
if has("autocmd")
  augroup fedora
  autocmd!
  " In text files, always limit the width of text to 78 characters
  " autocmd BufRead *.txt set tw=78
  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal! g'\"" |
  \ endif
  " don't write swapfile on most commonly used directories for NFS mounts or USB sticks
  autocmd BufNewFile,BufReadPre /media/*,/run/media/*,/mnt/* set directory=~/tmp,/var/tmp,/tmp
  " start with spec file template
  autocmd BufNewFile *.spec 0r /usr/share/vim/vimfiles/template.spec
  augroup END
endif

if has("cscope") && filereadable("/usr/bin/cscope")
   set csprg=/usr/bin/cscope
   set csto=0
   set cst
   set nocsverb
   " add any database in current directory
   if filereadable("cscope.out")
      cs add $PWD/cscope.out
   " else add database pointed to by environment
   elseif $CSCOPE_DB != ""
      cs add $CSCOPE_DB
   endif
   set csverb
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

filetype plugin on

if &term=="xterm"
     set t_Co=8
     set t_Sb=[4%dm
     set t_Sf=[3%dm
endif

" Don't wake up system with blinking cursor:
" http://www.linuxpowertop.org/known.php
let &guicursor = &guicursor . ",a:blinkon0"

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
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
Plugin 'scrooloose/nerdtree'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'tpope/vim-rails'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'mattn/emmet-vim'
Plugin 'othree/javascript-libraries-syntax.vim'
Plugin 'ap/vim-css-color'
Plugin 'bling/vim-bufferline'
Plugin 'epilande/vim-es2015-snippets'
Plugin 'lokaltog/vim-powerline'

" React code snippets
Plugin 'epilande/vim-react-snippets'

" Ultisnips
Plugin 'SirVer/ultisnips'
" Plugin 'lambdalisue/gina.vim'

" Trigger configuration (Optional)
let g:UltiSnipsExpandTrigger="<C-l>"
"
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
nmap <F6> :NERDTreeToggle<CR>

set encoding=utf-8
set laststatus=2
set number
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set colorcolumn=+1
set cursorline              " highligh current line
set ignorecase
set smartcase
set smartindent
set showmatch
set hlsearch
set gdefault
set virtualedit=block

" colors
colorscheme molokai
syntax on
set t_Co=256
set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 6
let Powerline_symbols = 'fancy'

inoremap <c-a> <esc>I
inoremap <c-e> <esc>A

" Return to the previously selected line in the file
augroup line_return
    au!
    au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \ execute 'normal! g`"zvzz' |
        \ endif
augroup END

" remove seach-highlights when pressing ,+<space>
let mapleader=","
noremap <leader><space> :noh<cr>: call clearmatches()<cr>

" Buffers, Backup & Co
set undodir=~/.vim/tmp/undo//
set backupdir=~/.vim/tmp/backup//
set directory=~/.vim/tmp/swap//
set backup
set noswapfile
set ruler
set history=10000
set undofile
set undoreload=10000
set title
set autoindent
set autoread
set lazyredraw
set mouse=a

" reload .vimrc on saving
au BufWritePost .vimrc so ~/.vimrc
execute pathogen#infect()
call pathogen#infect('bundle/{}')
nnoremap <F3> :NumbersToggle<CR>
nnoremap <F4> :NumbersOnOff<CR>
let g:bufferline_echo= 1
let g:bufferline_active_buffer_left = '['
let g:bufferline_active_buffer_right = ']'
