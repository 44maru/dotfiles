"--------------------
" ALE
"--------------------
let g:ale_linters = {}
let g:ale_linters['go'] = ['staticcheck', 'govet']
let g:ale_fixers = {}
let g:ale_fixers['go'] = ['golines']
let g:ale_go_golines_options = '-m 128'

"--------------------
" ag
"--------------------
nnoremap <expr> <C-h> ':Ag! --ignore "*test*" -G ".*.go" ' . expand("<cword>") . '<CR>'
nnoremap <expr> <Leader>fa ':Ag! --ignore "*test*" -G ".*.go" ' . expand("<cword>")
function! s:search_file()
  silent normal gv"zy
  silent execute ':Ag! --ignore "*test*" -G ".*.go" "' . @z . '"'
endfunction
