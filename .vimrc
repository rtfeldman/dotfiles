" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

call pathogen#infect()
" current plugins:
" vim-trailing-whitespace - https://github.com/bronson/vim-trailing-whitespace
" ctrlp.vim - https://github.com/kien/ctrlp.vim
" vim-airline - https://github.com/bling/vim-airline
" vim-colors-solarized - https://github.com/altercation/vim-colors-solarized
" vim-fugitive - https://github.com/tpope/vim-fugitive
" vim-rails - https://github.com/tpope/vim-rails
" vim-bundler - https://github.com/tpope/vim-bundler
" vim-multiple-cursors - https://github.com/terryma/vim-multiple-cursor

" don't clutter up the current directory with backups and swap files.
set backupdir=~/.vim/tmp
set directory=~/.vim/tmp

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Smart indentation with tabs being 2 spaces
set smartindent
set tabstop=2
set shiftwidth=2
set expandtab

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" Press Space to turn off highlighting and clear any message already displayed.
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Ignores for Ctrl-P
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git\|tmp\|public/assets'

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  set encoding=utf-8
  set hlsearch
  syntax on

  let g:solarized_termcolors=256
  set background=light
  colorscheme solarized

  if has("gui_macvim")
    set guifont=Source\ Code\ Pro\ for\ Powerline:h18
  else
    set guifont=Source\ Code\ Pro\ for\ Powerline\ 14
  endif

  " Remove the menus and toolbar
  set guioptions-=T
  set guioptions-=m

  let g:Powerline_symbols = 'fancy'
  let g:airline_powerline_fonts = 1
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif
