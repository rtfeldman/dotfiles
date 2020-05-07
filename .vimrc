" Global settings
filetype plugin indent on
syntax on

:scriptencoding utf-8
let &showbreak = '↪ '
set clipboard^=unnamed,unnamedplus
set completefunc=emoji#complete
set completeopt+=longest
set completeopt-=preview
set cursorline
set expandtab
set hidden
set mouse=a
set noswapfile
set number
set path=**
set shiftround
set shiftwidth=2

set splitright
set tabstop=2
set termguicolors
set ttyfast " removed in nvim
set undodir=~/tmp/vim/undo
set undofile
set wildignorecase
set noruler " Don't show the line or character count in the cmdline.

" # Plugin configuration
let g:EditorConfig_exclude_patterns = ['.git/COMMIT_EDITMSG']
let g:ale_fix_on_save = 1
let g:ale_elm_make_use_global=1
let g:ale_lint_delay = 0
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '!'
let g:elm_setup_keybindings = 0
let g:ale_rust_cargo_check_tests = 1
let g:haskell_indent_disable=1 "Automatic indenting and hindent don't agree
let g:localvimrc_persistent=2 "See plugin: embear/vim-localvimrc
let g:netrw_liststyle=1
let g:polyglot_disabled = ['haskell']
let g:startify_change_to_vcs_root = 1
let g:startify_session_delete_buffers = 1
let g:airline#extensions#bufferline#enabled = 1
let g:airline#extensions#ale#enabled = 1
let g:airline_theme='atomic' " nice with almost all colorschemes

if !isdirectory(expand(&undodir))
   call mkdir(expand(&undodir), 'p')
endif

" Show errors on \E
nnoremap <leader>e :ALEDetail<cr>

" Save on \S
nnoremap <leader>s :w<cr>

" Ctrl+S saves from either insert mode or normal mode.
nmap <c-s> :w<CR>
imap <c-s> <Esc>:w<CR>a

" Perform fuzzy file searching
nnoremap <C-P> mN:Files<cr>
nnoremap <C-B> mN:Buffers<CR>
nnoremap <C-/> mN:Lines<cr>
nnoremap <leader><leader> mN:Commands<cr>
nnoremap <leader>/ mN:History/<cr>
nnoremap <leader>: mN:History:<cr>
nnoremap <leader>? mN:Helptags<cr>


" Terminal mappings
nnoremap <silent> <C-T> :<c-u>exec v:count.'Ttoggle'<cr>
tnoremap <silent> <C-T> <C-\><C-n>:<c-u>exec v:count.'Ttoggle'<cr>
tnoremap <C-[> <C-\><C-n>
tnoremap <C-O> <C-\><C-n>`N

" Hightlight all incremental search results
map /  <plug>(incsearch-forward)
map ?  <plug>(incsearch-backward)
map g/ <plug>(incsearch-stay)

" :h g:incsearch#auto_nohlsearch
set hlsearch
let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)

" # Autocmds
augroup customCommands
  autocmd FileType elm set tabstop=4
  autocmd FileType elm set shiftwidth=4
  autocmd FileType roc set tabstop=4
  autocmd FileType roc set shiftwidth=4
  autocmd!
augroup END

" Plugins
call plug#begin('~/.vim/plugged')
  Plug 'joshdick/onedark.vim'
  Plug 'dense-analysis/ale' " Asynchronous linter
  Plug 'haya14busa/incsearch.vim' " Improved incremental searching
  Plug 'machakann/vim-highlightedyank' " highlighted yank
  Plug 'mhinz/vim-startify' " startup page
  Plug 'bronson/vim-visual-star-search' " select text, then press * or # to search for it
  Plug 'tpope/vim-commentary' " (Un)commenting lines
  Plug 'tpope/vim-repeat' " Use dot operator with plugins
  Plug 'tpope/vim-sensible' " Defaults everyone can agree on
  Plug 'tpope/vim-surround' " Commands to work with surroundings
  Plug 'junegunn/fzf' " fuzzy finder for files/buffers/etc
  Plug 'junegunn/fzf.vim' " vim plugin for fzf
  Plug 'bling/vim-bufferline' " show buffers in command line
  Plug 'vim-airline/vim-airline' " status line replacement
  Plug 'vim-airline/vim-airline-themes'
  Plug 'skywind3000/vim-auto-popmenu' " lightweight autocompletion
  Plug 'skywind3000/vim-dict' " autocompletion dictionary for several languages
  Plug 'ElmCast/elm-vim' " elm-format autosave, syntax highlighting, etc
call plug#end()

" enable vim-auto-popmenu plugin for filetypes, '*' for all files.
let g:apc_enable_ft = {'*':1}

" source for dictionary, current or other loaded buffers, see ':help cpt'
set cpt=.,k,w,b

" don't select the first item.
set completeopt=menu,menuone,noselect

" suppress annoying messages.
set shortmess+=c

" Use this theme:
colo onedark

" Don't show keystrokes in the status bar
set noshowcmd

" show colorcolumn at 81+ characters
let &colorcolumn=join(range(81,999),",")
highlight ColorColumn ctermfg=0 ctermbg=8 cterm=none

" don't show colorcolumn in quickfix
autocmd FileType qf let &colorcolumn=""

" Enable vim-sneak labels
let g:sneak#label = 1

" Ctrl-backspace deletes previous word
noremap! <C-BS> <C-w>
noremap! <C-h> <C-w>

" HIGHLIGHTEDYANK PLUGIN
let g:highlightedyank_highlight_duration = 250

let g:ale_linters = { 'haskell': ['hlint', 'hdevtools'] }

" Have Ale only run on save
let g:ale_lint_on_text_changed = 'never'

" Next/Prev error bindings for Ale
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" # Commands
command! ReloadConfig execute "source ~/.vimrc"

" Rg search via FZF - taken from https://github.com/junegunn/fzf.vim/blob/25bed070d83c6a230da371336829092a715edd07/README.md
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang Rg call RipgrepFzf(<q-args>, <bang>0)

" In ~/.vim/vimrc, or somewhere similar.
let g:ale_linters = {
\   'elm': ['make'],
\   'haskell': ['hlint', 'hdevtools']
\}

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'markdown': ['remove_trailing_lines'],
\   'rust': ['rustfmt'],
\}

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
