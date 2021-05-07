" Global settings
filetype plugin indent on
syntax on

:scriptencoding utf-8
let &showbreak = '↪ '
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
set ttyfast " removed in nvim
set undodir=~/tmp/vim/undo
set undofile
set wildignorecase
set noruler " Don't show the line or character count in the cmdline.

" Taken from https://github.com/rakr/vim-one (Credit: joshdick)
if (has("termguicolors"))
  set termguicolors
endif

set clipboard=unnamed,unnamedplus

" remap <leader> to ,
let mapleader = ","

" # Plugin configuration
let g:EditorConfig_exclude_patterns = ['.git/COMMIT_EDITMSG']
let g:ale_fix_on_save = 1
let g:ale_elm_make_use_global=1
let g:ale_lint_delay = 0
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '!'
let g:elm_setup_keybindings = 0
let g:ale_rust_cargo_check_tests = 1
let g:haskell_indent_disable=1 " Automatic indenting and hindent don't agree
let g:localvimrc_persistent=2 " See plugin: embear/vim-localvimrc
let g:netrw_liststyle=1
let g:polyglot_disabled = ['haskell', 'elm']
let g:startify_change_to_vcs_root = 1
let g:startify_session_delete_buffers = 1
let g:airline#extensions#ale#enabled = 1
let g:airline_theme='atomic'

if !isdirectory(expand(&undodir))
   call mkdir(expand(&undodir), 'p')
endif

" Show errors on <leader>e
nnoremap <leader>e :ALEDetail<cr>

" Save on <leader>s
nnoremap <leader>s :w<cr>

" Quit on <leader>q
nnoremap <leader>q :q<cr>

" Ctrl+S saves from either insert mode or normal mode.
nmap <c-s> :w<CR>
imap <c-s> <Esc>:w<CR>a

" Pasting over a selection shouldn't alter the clipboard - via https://stackoverflow.com/a/7797434
xnoremap p pgvy

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
  Plug 'rakr/vim-one' " theme (includes both One Dark and One Light)
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
  Plug 'stefandtw/quickfix-reflector.vim' "  Make quickfix window editable
  Plug 'vim-airline/vim-airline' " status line replacement
  Plug 'vim-airline/vim-airline-themes'
  Plug 'prabirshrestha/asyncomplete.vim' " autocomplete
  Plug 'prabirshrestha/asyncomplete-buffer.vim' " autocomplete using contents of current buffer
  Plug 'ElmCast/elm-vim' " elm-format on autosave
  Plug 'sheerun/vim-polyglot' " syntax highlighting for lots of things
  Plug 'danro/rename.vim' " adds :Rename command
  Plug 'phanviet/vim-monokai-pro'
call plug#end()

" # Register asyncomplete-buffer as a source for asyncomplete
call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
    \ 'name': 'buffer',
    \ 'whitelist': ['*'],
    \ 'blacklist': ['go'],
    \ 'completor': function('asyncomplete#sources#buffer#completor'),
    \ 'config': {
    \    'max_buffer_size': 5000000,
    \  },
    \ }))

" # Tab completion for asyncomplete
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? "\<C-y>" : "\<cr>"

" Use this theme:
colorscheme monokai_pro
set background=dark " for the dark version
" set background=light " for the light version


" Don't show keystrokes in the status bar
set noshowcmd

" show colorcolumn at 81+ characters
let &colorcolumn=join(range(81,999),",")
highlight ColorColumn ctermfg=0 ctermbg=8 cterm=none

hi Visual  guifg=#000000 guibg=#FFFFFF gui=none

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
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --hidden --column --line-number --no-heading --glob "!.git/*" --color=always '.shellescape(<q-args>).'| tr -d "\017"', 1,
  \   { 'options': '--bind ctrl-a:select-all,ctrl-d:deselect-all' },
  \   <bang>0)

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

" For now.
autocmd BufRead,BufNewFile *.roc set filetype=coffee
