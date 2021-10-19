function! antovim#swap()
  if exists('b:antovim_definitions')
    let dictionary = extend(copy(g:antovim_definitions), b:antovim_definitions)
  else
    let dictionary = g:antovim_definitions
  endif

  if exists('g:custom_antovim_definitions')
    let dictionary = extend(copy(g:custom_antovim_definitions), dictionary)
  endif

  let word = expand("<cword>") 

  for d in dictionary
    let idx = index(d, word)

    if idx > -1
      if idx == len(d) - 1
        let substitute = d[0]
      else
        let substitute = d[idx + 1]
      endif

      execute "normal! ciw" . substitute
      break
    endif
  endfor
endfunction
