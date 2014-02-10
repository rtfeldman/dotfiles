" Use Cmd-T (Mac) and Ctrl-T (other) to open CtrlP
if has("gui_macvim")
  macmenu &File.New\ Tab key=<nop>
  map <D-t> :CtrlP<CR>

  " Copy into system clipboard (MacVim)
  nnoremap y "*y
  vnoremap y "*y

  " Paste from system clipboard (MacVim)
  set clipboard=unnamed
else
  map <c-t> :CtrlP<CR>

  " Copy into system clipboard (X11)
  nnoremap y "+y
  vnoremap y "+y

  " Paste from system clipboard (X11)
  set clipboard=unnamedplus
endif
