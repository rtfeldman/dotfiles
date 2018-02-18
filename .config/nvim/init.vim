source ~/brangelina/brangelina.vim


call plug#begin('~/.vim/plugged')
  call BrangelinaPlugins()

  Plug 'easymotion/vim-easymotion'
  Plug 'joshdick/onedark.vim'
call plug#end()

" -- THEME --
set background=dark

" -- Use this theme:
colo onedark

" -- Don't show the mode (e.g. --INSERT--) - I know what mode I'm in!
set noshowmode

" -- Don't show keystrokes in the status bar
set noshowcmd

" -- Use the system clipboard
set clipboard=unnamed,unnamedplus

set noruler " Don't show the line or character count in the cmdline.

let g:neoterm_shell = 'zsh'

" show colorcolumn at 81+ characters
let &colorcolumn=join(range(81,999),",")
highlight ColorColumn ctermfg=0 ctermbg=8 cterm=none

" don't show colorcolumn in quickfix
autocmd FileType qf let &colorcolumn=""

" Ctrl+S saves from either insert mode or normal mode.
map <C-s> :w<kEnter>
imap <C-s> <Esc>:w<kEnter>i

" -- HIGHLIGHTEDYANK PLUGIN --

let g:highlightedyank_highlight_duration = 250

" -- GITGUTTER PLUGIN --

" disable gitgutter by default
let g:gitgutter_enabled = 0

" -- EASYMOTION PLUGIN --

map <Leader> <Plug>(easymotion-prefix)

" -- MISC --

" These interfere with NRI stuff somehow
let g:neoformat_enabled_json = []

let g:neoformat_enabled_ruby = []

" (4) Configure the theme you want to use below.
let g:lightline = {
      \ 'colorscheme': 'one',
      \ 'active': {
      \   'right': [ [ 'gitbranch' ], [ 'readonly', 'modified', 'paste' ] ],
      \   'left': [ [ 'filename'], [ 'ale' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head',
      \   'ale': 'ALEGetStatusLine'
      \ }
\ }

let g:ale_linters = { 'haskell': ['hlint', 'hdevtools'] }
