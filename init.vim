" ------- PLUGINS  -------

call plug#begin('~/.vim/plugged')
  " Plugins that make for a nice general UX
  Plug 'tpope/vim-fugitive'
  Plug 'kien/ctrlp.vim'
  Plug 'jeetsukumaran/vim-buffergator'
  Plug 'rking/ag.vim'
  Plug 'tomtom/tcomment_vim'
  Plug 'tpope/vim-surround'
  Plug 'vim-scripts/AutoComplPop'
  Plug 'Olical/vim-enmasse'
  Plug 'kana/vim-operator-user' " vim-operator-flashy depends on this
  Plug 'haya14busa/vim-operator-flashy'
  Plug 'ntpeters/vim-better-whitespace'
  Plug 'easymotion/vim-easymotion'

  " Plugins individual to my development setup
  Plug 'w0ng/vim-hybrid' " Theme
  Plug 'elmcast/elm-vim', { 'for': 'elm' }
  Plug 'vim-ruby/vim-ruby', { 'for': 'rb' }
  Plug 'cakebaker/scss-syntax.vim', { 'for': ['scss', 'sass'] }
  Plug 'kchmck/vim-coffee-script', { 'for': 'coffee' }
call plug#end()


" ------- THEME -------

syntax enable

set background=dark

let g:hybrid_custom_term_colors = 1
let g:hybrid_reduced_contrast = 1

colorscheme hybrid


" ------- KEY BINDINGS -------

map <Leader> <Plug>(easymotion-prefix)

" <leader>w closes current buffer, and <leader>W closes without saving
" nnoremap <silent> <leader>w :silent bdelete<CR>
" nnoremap <silent> <leader>W :silent bdelete!<CR>

" Don't use Ex mode, use Q to open Quickfix
nnoremap Q :silent :copen<CR>

" Ctrl+S saves from either insert mode or normal mode.
map <C-s> :w<kEnter>
imap <C-s> <Esc>:w<kEnter>i

" Press Esc to turn off highlighting, close quickfix, and clear the cmdline
nnoremap <silent> <esc> :nohlsearch<Bar>:cclose<BAR>:echo<CR><esc>

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" Move between windows with Tab
nnoremap <tab> <C-w><C-w>


" ------- GENERAL UX -------

" Don't wrap long lines
set nowrap

" show colorcolumn at 81+ characters
let &colorcolumn=join(range(81,999),",")

" don't show colorcolumn in quickfix
autocmd FileType qf let &colorcolumn=""

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

" Do diffs with a vertical side-by-side like GitHub.
set diffopt+=vertical

" Don't show the status line. The clutter is not worth it.
set laststatus=0

" Use the system clipboard.
set clipboard=unnamed

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
set autoindent

" Line numbers!
set number

" Color line numbers similarly to colorcolumn
hi LineNr ctermfg=0 ctermbg=8 cterm=none

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
set noruler " Don't show the line or character count in the cmdline.
set showcmd   " display incomplete commands
set incsearch   " do incremental searching

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Wild ignores
set wildignore+=*.o,*.obj,.git,*.png,*.jpg,*.jpeg,*.gif,*.bmp,*.tif,*.tiff,*.mpg,*.mpeg,*.psd,*.ico,*.cur

" Only do this part when compiled with support for autocommands.
if has("autocmd")
  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  " .hamlc syntax highlighting
  au BufRead,BufNewFile *.hamlc set ft=haml
else

  set autoindent    " always set autoindenting on

endif " has("autocmd")


" ------- OPERATOR-FLASHY PLUGIN -------

" Enable operator-flashy
map y <Plug>(operator-flashy)
nmap Y <Plug>(operator-flashy)$

" Flash dark blue on yank
hi default Flashy term=bold ctermbg=blue guibg=blue ctermfg=black guifg=black
hi default Cursor cterm=bold ctermbg=blue guibg=blue ctermfg=black guifg=black
let g:operator#flashy#flash_time = 250

" ------- THE_SILVER_SEARCHER (AKA AG) PLUGIN ------

" Have ag.vim always start from project root instead of cwd
let g:ag_working_path_mode="r"

" Have ag.vim use our ignores list
let g:ag_prg="ag --nocolor --vimgrep"

" Pass --smart-case to ag by default
let g:AgSmartCase = 1

" Bind <leader>a to bring up Ag prompt
nnoremap <expr> <leader>a ":Ag! "

" ------- BUFFERGATOR PLUGIN -------

let g:buffergator_viewport_split_policy = 'B'
let g:buffergator_sort_regime = 'mru'

" ------- CTRLP PLUGIN ------

" Show results in top-to-bottom order instead of bottom-to-top
let g:ctrlp_match_window_reversed = 0

" Incorporate our Ag ignore list into CtrlP
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'


" ------- ELM-VIM PLUGIN -------

" Run elm-format on autosave
let g:elm_format_autosave = 1


" ------- STRIP-WHITESPACE PLUGIN -------

" Strip trailing whitspace on save, with the given exceptions.
autocmd BufWritePre * StripWhitespace
let g:better_whitespace_filetypes_blacklist = ['md', 'diff', 'gitcommit', 'unite', 'qf', 'help']
