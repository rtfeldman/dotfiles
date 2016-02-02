call plug#begin('~/.vim/plugged')
  " Plugins that make for a nice general UX
  Plug 'tpope/vim-fugitive'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'ap/vim-buftabline'
  Plug 'rking/ag.vim'
  Plug 'tomtom/tcomment_vim'
  Plug 'tpope/vim-surround'
  Plug 'henrik/vim-indexed-search'
  Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }

  " Plugins individual to my setup
  Plug 'w0ng/vim-hybrid'
  Plug 'elmcast/elm-vim', { 'for': 'elm' }
  Plug 'vim-ruby/vim-ruby', { 'for': 'rb' }
  Plug 'cakebaker/scss-syntax.vim', { 'for': ['scss', 'sass'] }
  Plug 'vim-coffee-script'
call plug#end()

" change the mapleader from \ to ,
let g:mapleader=","

" Use ; instead of : and ;; instead of the original ;
" http://vim.wikia.com/wiki/Map_semicolon_to_colon
noremap ;; ;
map ; :

" Use system clipboard
set clipboard=unnamed

" Do diffs with a vertical side-by-side like GitHub
set diffopt+=vertical

let g:base16_shell_path='/Users/rtfeldman/code/base16-builder/output/shell/'
if !has('gui_running')
  if exists("g:base16_shell_path")
    execute "silent !/bin/sh ".g:base16_shell_path."/base16-materialtheme.".&background.".sh"
  endif
endif

" Cycle through buffers with tab and shif-tab in normal mode
:nnoremap <silent> <Tab> :bnext!<CR>
:nnoremap <silent> <S-Tab> :bprevious!<CR>
:nnoremap <silent> <leader>w :bdelete<CR>

let ag_ignores = '--ignore "vendor/" --ignore "*.png" --ignore "*.jpg" --ignore "*.jpeg" --ignore "*.gif" --ignore "*.bmp" --ignore "*.tif" --ignore "*.tiff" --ignore "*.mpg" --ignore "*.mpeg" --ignore "*.cur" --ignore "*.ico" --ignore "*.psd"'

" Have ag.vim always start from project root instead of cwd
let g:ag_working_path_mode="r"

" Have ag.vim use our ignores list
let g:ag_prg="ag " . ag_ignores . " --vimgrep"

" Have FZF use ag, with our ignores, and without searching inside files
let $FZF_DEFAULT_COMMAND = 'ag ' . ag_ignores . ' -l -g ""'

" Incorporate fzf into Neovim's Statusline
function! s:fzf_statusline()
  " Override statusline as you like
  highlight fzf1 ctermfg=161 ctermbg=251
  highlight fzf2 ctermfg=23 ctermbg=251
  highlight fzf3 ctermfg=237 ctermbg=251
  setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
endfunction

autocmd! User FzfStatusLine call <SID>fzf_statusline()

syntax enable
set background=dark
colorscheme hybrid

" Don't show the status line
set laststatus=0

" show in buftabline when a buffer is modified
let g:buftabline_indicators = 1

" only show buftabline when there are at least 2 buffers open
let g:buftabline_show = 1

" elm-vim
let g:elm_format_autosave = 1

let g:fzf_command_prefix = 'Fzf'

if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" Show cursor line in normal mode
set cursorline
:autocmd InsertEnter * set nocursorline
:autocmd InsertLeave * set cursorline

" Works in normal mode, must press Esc first
:map <C-s> :w<kEnter>
:map <C-t> :FZF<kEnter>

" Works in insert mode, saves and puts back in insert mode
:imap <C-s> <Esc>:w<kEnter>i
:imap <C-t> <Esc>:FZF<kEnter>

" don't clutter up the current directory with backups and swap files.
set backupdir=~/.nvim/tmp
set directory=~/.nvim/tmp

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Smart indentation with tabs being 2 spaces
set smartindent
set tabstop=2
set shiftwidth=2
set expandtab

" Line numbers!
set number

" ignore case when searching, except when searching for caps, in which case
" don't ignore case.
set ignorecase
set smartcase

if has("vms")
  set nobackup    " do not keep a backup file, use versions instead
else
  set backup    " keep a backup file
endif

set history=99    " keep 99 lines of command line history
set ruler   " show the cursor position all the time
set showcmd   " display incomplete commands
set incsearch   " do incremental searching
set colorcolumn=80 " show a vertical line at 80 chars

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

" Wild ignores
set wildignore+=*.o,*.obj,.git,*.png,*.jpg,*.jpeg,*.gif,*.bmp,*.tif,*.tiff,*.mpg,*.mpeg,*.psd,*.ico,*.cur


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

  " .hamlc syntax highlighting
  au BufRead,BufNewFile *.hamlc set ft=haml
else

  set autoindent    " always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
      \ | wincmd p | diffthis
endif

" See https://github.com/lukaszkorecki/CoffeeTags
" (remember to gem install CoffeeTags when installing on a new system!)
if executable('coffeetags')
  let g:tagbar_type_coffee = {
        \ 'ctagsbin' : 'coffeetags',
        \ 'ctagsargs' : '',
        \ 'kinds' : [
        \ 'f:functions',
        \ 'o:object',
        \ ],
        \ 'sro' : ".",
        \ 'kind2scope' : {
        \ 'f' : 'object',
        \ 'o' : 'object',
        \ }
        \ }
endif

" Bring up the Tagbar - http://majutsushi.github.io/tagbar/
nmap <F6> :TagbarToggle<CR>

" mkdir -p on save when editing a file in a directory that doesn't exist yet
function s:MkNonExDir(file, buf)
  if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
    let dir=fnamemodify(a:file, ':h')
    if !isdirectory(dir)
      call mkdir(dir, 'p')
    endif
  endif
endfunction

augroup BWCCreateDir
  autocmd!
  autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END

let g:syntastic_haskell_checkers = ['hdevtools']
let g:syntastic_coffeescript_checkers = ['coffee']
let g:syntastic_ruby_checkers = ['mri']

