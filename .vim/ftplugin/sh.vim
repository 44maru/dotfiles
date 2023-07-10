"--------------------
" ALE
"--------------------
let g:ale_linters = {}
let g:ale_linters['sh'] = ['shellcheck']
let g:ale_sh_shellcheck_options = '-e SC2086'
let g:ale_fixers = {}
let g:ale_fixers['sh'] = ['shfmt']
let g:ale_sh_shfmt_options = '-i 4'

