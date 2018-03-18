source ~/brangelina/brangelina.vim


call plug#begin('~/.vim/plugged')
  call BrangelinaPlugins()

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

" Enable vim-sneak labels
let g:sneak#label = 1

" Ctrl-backspace deletes previous word
noremap! <C-BS> <C-w>
noremap! <C-h> <C-w>

" -- HIGHLIGHTEDYANK PLUGIN --

let g:highlightedyank_highlight_duration = 250

" -- GITGUTTER PLUGIN --

" disable gitgutter by default
let g:gitgutter_enabled = 0

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

" Have Ale only run on save
let g:ale_lint_on_text_changed = 'never'

" Next/Prev error bindings for Ale
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" Use :GFiles for ctrl+p by default. Fall back on :Files if not in a git repo.
function! GFilesFallback()
  let output = system('git rev-parse --show-toplevel') " Is there a faster way?
  let prefix = get(g:, 'fzf_command_prefix', '')
  if v:shell_error == 0
    exec "normal :" . prefix . "GFiles\<CR>"
  else
    exec "normal :" . prefix . "Files\<CR>"
  endif
  return 0
endfunction

nnoremap <c-p> :call GFilesFallback()<CR>

" Don't autoformat markdown
let g:neoformat_enabled_markdown = []
