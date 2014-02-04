# Use Cmd-T (Mac) and Ctrl-T (other) to open CtrlP
if has("gui_macvim")
  macmenu &File.New\ Tab key=<nop>
  map <D-t> :CtrlP<CR>
else
  map <c-t> :CtrlP<CR>
endif
