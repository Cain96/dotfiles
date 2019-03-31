" PowerlineçłťăăŠăłăăĺŠç¨ăă
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#whitespace#mixed_indent_algo = 1
let g:airline_theme = 'papercolor'

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = 'Âť'
let g:airline_left_sep = 'âś'
let g:airline_right_sep = 'ÂŤ'
let g:airline_right_sep = 'â'
let g:airline_symbols.crypt = 'đ'
let g:airline_symbols.linenr = 'â'
let g:airline_symbols.linenr = 'â¤'
let g:airline_symbols.linenr = 'Âś'
let g:airline_symbols.maxlinenr = 'â°'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.branch = 'â'
let g:airline_symbols.paste = 'Ď'
let g:airline_symbols.paste = 'Ă'
let g:airline_symbols.paste = 'âĽ'
let g:airline_symbols.spell = 'ę¨'
let g:airline_symbols.notexists = 'â'
let g:airline_symbols.whitespace = 'Î'

" powerline symbols
let g:airline_left_sep = 'î°'
let g:airline_left_alt_sep = 'îą'
let g:airline_right_sep = 'î˛'
let g:airline_right_alt_sep = 'îł'
let g:airline_symbols.branch = 'î '
let g:airline_symbols.readonly = 'î˘'
let g:airline_symbols.linenr = 'îĄ'

" old vim-powerline symbols
" let g:airline_left_sep = 'âŽ'
" let g:airline_left_alt_sep = 'âŽ'
let g:airline_right_sep = 'âŽ'
let g:airline_right_alt_sep = 'âŽ'
" let g:airline_symbols.branch = 'â­ '
" let g:airline_symbols.readonly = 'â­¤'
" let g:airline_symbols.linenr = 'â­Ą'
