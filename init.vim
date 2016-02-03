" ------- PLUGINS  -------

call plug#begin('~/.vim/plugged')
  " Plugins that make for a nice general UX
  Plug 'tpope/vim-fugitive'
  Plug 'kien/ctrlp.vim'
  Plug 'rking/ag.vim'
  Plug 'tomtom/tcomment_vim'
  Plug 'tpope/vim-surround'
  Plug 'henrik/vim-indexed-search'
  Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
  Plug 'kana/vim-operator-user' " vim-operator-flashy depends on this
  Plug 'haya14busa/vim-operator-flashy'
  Plug 'ntpeters/vim-better-whitespace'

  " Plugins individual to my development setup
  Plug 'w0ng/vim-hybrid' " Theme
  Plug 'elmcast/elm-vim', { 'for': 'elm' }
  Plug 'vim-ruby/vim-ruby', { 'for': 'rb' }
  Plug 'cakebaker/scss-syntax.vim', { 'for': ['scss', 'sass'] }
  Plug 'vim-coffee-script'
call plug#end()


" ------- KEY BINDINGS -------

" change the mapleader from \ to ,
let g:mapleader=","

" Use ; instead of : because honestly the default ; is pretty worthless.
" http://vim.wikia.com/wiki/Map_semicolon_to_colon
map ; :

" Cycle through buffers with tab and shif-tab in normal mode
nnoremap <silent> <Tab> :silent bnext!<CR>
nnoremap <silent> <S-Tab> :silent bprevious!<CR>
nnoremap <silent> <leader>w :silent bdelete<CR>
nnoremap <silent> <leader>W :silent bdelete!<CR>
" Jump to a particular buffer with <Leader> followed by buffer number.
nnoremap <silent> <Leader>1 :silent 1b<CR>
nnoremap <silent> <Leader>2 :silent 2b<CR>
nnoremap <silent> <Leader>3 :silent 3b<CR>
nnoremap <silent> <Leader>4 :silent 4b<CR>
nnoremap <silent> <Leader>5 :silent 5b<CR>
nnoremap <silent> <Leader>6 :silent 6b<CR>
nnoremap <silent> <Leader>7 :silent 7b<CR>
nnoremap <silent> <Leader>8 :silent 8b<CR>
nnoremap <silent> <Leader>9 :silent 9b<CR>
nnoremap <silent> <Leader>0 :silent 10b<CR>

" Ctrl+S saves from either insert mode or normal mode.
:map <C-s> :w<kEnter>
:imap <C-s> <Esc>:w<kEnter>i

" Press Space to turn off highlighting and clear any message already displayed.
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>


" ------- GENERAL UX -------

" Don't wrap long lines
set nowrap

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
set noruler " Don't show the line or character count in the cmdline.
set showcmd   " display incomplete commands
set incsearch   " do incremental searching
set colorcolumn=80 " show a vertical line at 80 chars

" Don't use Ex mode, use Q for formatting
map Q gq

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


" ------- THEME -------

syntax enable

set background=dark

let g:hybrid_custom_term_colors = 1
let g:hybrid_reduced_contrast = 1

colorscheme hybrid


" ------- OPERATOR-FLASHY PLUGIN -------

" Enable operator-flashy
map y <Plug>(operator-flashy)
nmap Y <Plug>(operator-flashy)$

" Flash dark blue on yank
hi default Flashy term=bold ctermbg=blue guibg=blue ctermfg=black guifg=black
hi default Cursor cterm=bold
let g:operator#flashy#flash_time = 250

" ------- THE_SILVER_SEARCHER (AKA AG) PLUGIN ------

let ag_ignores = '--ignore "vendor/" --ignore "*.png" --ignore "*.jpg" --ignore "*.jpeg" --ignore "*.gif" --ignore "*.bmp" --ignore "*.tif" --ignore "*.tiff" --ignore "*.mpg" --ignore "*.mpeg" --ignore "*.cur" --ignore "*.ico" --ignore "*.psd"'

" Have ag.vim always start from project root instead of cwd
let g:ag_working_path_mode="r"

" Have ag.vim use our ignores list
let g:ag_prg="ag --nocolor " . ag_ignores . " --vimgrep"

" Pass --smart-case to ag by default
let g:AgSmartCase = 1


" ------- CTRLP PLUGIN ------

" Show results in top-to-bottom order instead of bottom-to-top
let g:ctrlp_match_window_reversed = 0

" Incorporate our Ag ignore list into CtrlP
let g:ctrlp_user_command = 'ag %s -l --nocolor -g "" ' . ag_ignores


" ------- ELM-VIM PLUGIN -------

" Run elm-format on autosave
let g:elm_format_autosave = 1


" ------- STRIP-WHITESPACE PLUGIN -------

" Strip trailing whitspace on save, with the given exceptions.
autocmd BufWritePre * StripWhitespace
let g:better_whitespace_filetypes_blacklist = ['md', 'diff', 'gitcommit', 'unite', 'qf', 'help']
