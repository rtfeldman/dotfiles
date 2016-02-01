call plug#begin('~/.vim/plugged')
  Plug 'w0ng/vim-hybrid'
  Plug 'tpope/vim-fugitive'
  Plug 'elmcast/elm-vim'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'bling/vim-bufferline'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
call plug#end()

let g:base16_shell_path='/Users/rtfeldman/code/base16-builder/output/shell/'
if !has('gui_running')
  if exists("g:base16_shell_path")
    execute "silent !/bin/sh ".g:base16_shell_path."/base16-materialtheme.".&background.".sh"
  endif
endif

" Have vim-bufferline show buffer numbers
let g:bufferline_show_bufnr = 1
let g:bufferline_active_buffer_left = '['
let g:bufferline_active_buffer_right = ']'
let g:bufferline_modified = '+'
let g:bufferline_inactive_highlight = 'StatusLineNC'
let g:bufferline_active_highlight = 'StatusLine'
let g:bufferline_solo_highlight = 1
let g:bufferline_echo = 0
  autocmd VimEnter *
    \ let &statusline='%{bufferline#refresh_status()}'
      \ .bufferline#get_status_string()

" Cycle through buffers with tab and shif-tab in normal mode
:nnoremap <Tab> :bnext<CR>
:nnoremap <S-Tab> :bprevious<CR>

" Use system clipboard
set clipboard=unnamed

" Do diffs with a vertical side-by-side like GitHub
set diffopt+=vertical

" FZF
let $FZF_DEFAULT_COMMAND = 'ag --ignore "vendor/" --ignore "*.png" --ignore "*.jpg" --ignore "*.jpeg" --ignore "*.gif" --ignore "*.bmp" --ignore "*.tif" --ignore "*.tiff" --ignore "*.mpg" --ignore "*.mpeg" --ignore "*.psd" -l -g ""'

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

" airline
let g:airline_theme = "hybrid"
let g:airline_powerline_fonts = 1

" Enable the list of buffers
"let g:airline#extensions#tabline#enabled = 1
" Show just the filename
"let g:airline#extensions#tabline#fnamemod = ':t'

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

:autocmd InsertEnter * set cul
:autocmd InsertLeave * set nocul

" Works in normal mode, must press Esc first
:map <C-s> :w<kEnter>
:map <C-t> :FZF<kEnter>

" Works in insert mode, saves and puts back in insert mode
:imap <C-s> <Esc>:w<kEnter>i
:imap <C-t> <Esc>:FZF<kEnter>i

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
set wildignore+=*.o,*.obj,.git,*.png,*.jpg,*.jpeg,*.gif,*.bmp,*.tif,*.tiff,*.mpg,*.mpeg,*.psd


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

" Custom airline from https://github.com/blaenk/dots/blob/275b3b40fa0c57f1b48b5ba59b9ecbc00cddf866/vim/vimrc.ln#L80-L202

let g:airline#extensions#hunks#enabled = 0
let g:airline#extensions#whitespace#enabled = 0

function! AirLineBlaenk()
  function! Modified()
    return &modified ? " +" : ''
  endfunction

  call airline#parts#define_raw('filename', '%<%f')
  call airline#parts#define_function('modified', 'Modified')

  let g:airline_section_a = airline#section#create_left(['filename'])
  let g:airline_section_b = airline#section#create_left([''])
  let g:airline_section_x = airline#section#create_right([''])
  let g:airline_section_y = airline#section#create_right([''])
  let g:airline_section_z = airline#section#create(['branch'])
endfunction

autocmd Vimenter * call AirLineBlaenk()
set laststatus=0

let g:airline_mode_map = {
  \ '__' : '-',
  \ 'n'  : 'N',
  \ 'i'  : 'I',
  \ 'R'  : 'R',
  \ 'v'  : 'V',
  \ 'V'  : 'V-L',
  \ 'c'  : 'C',
  \ '' : 'V-B',
  \ 's'  : 'S',
  \ 'S'  : 'S-L',
  \ '' : 'S-B',
  \ }
