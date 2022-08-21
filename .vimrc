syntax on
filetype plugin indent on

set clipboard=unnamed,unnamedplus

:scriptencoding utf-8
let &showbreak = '↪ '
set tabstop=2
set ttyfast " removed in nvim
set undodir=~/tmp/vim/undo
set undofile
set wildignorecase

if !isdirectory(expand(&undodir))
   call mkdir(expand(&undodir), 'p')
endif

" Ctrl+S saves from either insert mode or normal mode.
nmap <c-s> :w<CR>
imap <c-s> <Esc>:w<CR>a

" Pasting over a selection shouldn't alter the clipboard - via https://stackoverflow.com/a/7797434
xnoremap p pgvy

" Don't show keystrokes in the status bar
set noshowcmd

" Ctrl-backspace deletes previous word
noremap! <C-BS> <C-w>
noremap! <C-h> <C-w>

set viminfo='100,n$HOME/.vim/files/info/viminfo

if &term =~ "xterm"
  " normal mode caret: solid vertical block
  let &t_SI .= "\<Esc>[6 q"
  " insert mode caret: solid vertical var
  let &t_EI .= "\<Esc>[2 q"
endif

" Without this, there's a delay when changing to/from the insert mode caret
set ttimeout
set ttimeoutlen=1
set listchars=tab:>-,trail:~,extends:>,precedes:<,space:.
set ttyfast

