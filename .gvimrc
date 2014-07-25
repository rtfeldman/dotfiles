" Use Cmd-T (Mac) and Ctrl-T (other) to open CtrlP
if has("gui_macvim")
  macmenu &File.New\ Tab key=<nop>
  map <D-t> :CommandT<CR>

  " Use system clipboard (MacVim)
  set clipboard=unnamed
else
  map <c-t> :CtrlP<CR>

  " Use system clipboard (X11)
  set clipboard=unnamedplus
endif
