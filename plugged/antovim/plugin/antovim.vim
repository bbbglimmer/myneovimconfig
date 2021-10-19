if exists("g:loaded_antovim") || &cp
  finish
endif

let g:loaded_antovim = '0.0.0' " version number
let s:keepcpo = &cpo
set cpo&vim

let g:antovim_definitions = [
  \   ['acquire', 'release'],
  \   ['add', 'remove'],
  \   ['advance', 'retreat'],
  \   ['allocate', 'deallocate'],
  \   ['allow', 'deny'],
  \   ['assemble', 'disassemble'],
  \   ['assign', 'deassign'],
  \   ['associate', 'dissociate'],
  \   ['attach', 'detach'],
  \   ['begin', 'end'],
  \   ['bind', 'unbind'],
  \   ['commit', 'rollback'],
  \   ['compile', 'decompile'],
  \   ['compose', 'parse'],
  \   ['compress', 'decompress'],
  \   ['connect', 'disconnect'],
  \   ['construct', 'destruct'],
  \   ['create', 'destroy'],
  \   ['do', 'undo'],
  \   ['enable', 'disable'],
  \   ['encode', 'decode'],
  \   ['encrypt', 'decrypt'],
  \   ['enqueue', 'dequeue'],
  \   ['enter', 'leave'],
  \   ['expand', 'collapse'],
  \   ['first', 'last'],
  \   ['freeze', 'unfreeze'],
  \   ['front', 'back'],
  \   ['get', 'set'],
  \   ['grant', 'revoke'],
  \   ['head', 'tail'],
  \   ['high', 'low'],
  \   ['import', 'export'],
  \   ['include', 'exclude'],
  \   ['increase', 'decrease'],
  \   ['increment', 'decrement'],
  \   ['indent', 'dedent'],
  \   ['inflate', 'deflate'],
  \   ['inject', 'eject'],
  \   ['input', 'output'],
  \   ['insert', 'delete'],
  \   ['install', 'uninstall'],
  \   ['left', 'right'],
  \   ['Left', 'Right'],
  \   ['link', 'unlink'],
  \   ['load', 'unload'],
  \   ['lock', 'unlock'],
  \   ['maximum', 'minimum'],
  \   ['new', 'old'],
  \   ['next', 'previous'],
  \   ['open', 'close'],
  \   ['paste', 'cut'],
  \   ['push', 'pop'],
  \   ['read', 'write'],
  \   ['reference', 'dereference'],
  \   ['register', 'deregister'],
  \   ['resume', 'suspend'],
  \   ['select', 'deselect'],
  \   ['send', 'receive'],
  \   ['serialize', 'deserialize'],
  \   ['set', 'unset'],
  \   ['set', 'up tear down'],
  \   ['show', 'hide'],
  \   ['start', 'stop'],
  \   ['true', 'false'],
  \   ['True', 'False'],
  \   ['TRUE', 'FALSE'],
  \   ['up', 'down'],
  \   ['Up', 'Down'],
  \   ['upper', 'lower'],
  \ ]

autocmd FileType css,less let b:antovim_definitions = [
  \   ['top', 'bottom', 'left', 'right'],
  \   ['block', 'inline-block', 'inline', 'none'],
  \   ['absolute', 'fixed', 'relative', 'static'],
  \   ['px', 'em', 'rem', '%'],
  \ ]

autocmd FileType html,ejs, let b:antovim_definitions = [
  \   ['div', 'span']
  \ ]


command! Antovim call antovim#swap() | silent! call repeat#set("\<Plug>Antovim")

nnoremap gs :Antovim<cr>

let &cpo = s:keepcpo
unlet s:keepcpo
