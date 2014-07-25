" Use Cmd-T (Mac) and Ctrl-T (other) to open CtrlP
if has("gui_macvim")
  macmenu &File.New\ Tab key=<nop>

  " Open CommandT when you press Cmd+T
  map <D-t> :CommandT<CR>

  " Have CommandT open files in a new tab by default
  let g:CommandTAcceptSelectionMap = '<C-t>'
  let g:CommandTAcceptSelectionTabMap = '<CR>'

  " Use system clipboard (MacVim)
  set clipboard=unnamed
else
  map <c-t> :CtrlP<CR>

  " Use system clipboard (X11)
  set clipboard=unnamedplus
endif
