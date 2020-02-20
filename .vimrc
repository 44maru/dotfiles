syntax on

set ts=4 "tabstop
set sw=4 "shiftwidth
set expandtab "convert tab to space.
set cursorline

" Enable Alt + m as <M-m>
execute "set <M-m>=\em"
" Enable Alt + f as <M-f>
execute "set <M-f>=\ef"

"retab command
"if you set expandtab   --> convert tab to space.
"if you set noexpandtab --> convert space to tab.

"set autoindent
set hlsearch
"set number

"set mouse=a
"set mouse=n
let mapleader = ";"
" ctags
set tags=tags;

"===========================================
" Reload vimrc
"===========================================
augroup source-vimrc
  autocmd!
  autocmd BufWritePost *vimrc source $MYVIMRC | set foldmethod=marker
augroup END


"===========================================
" Encoding
"===========================================
set encoding=utf-8
set fileencodings=iso-2022-jp,euc-jp,sjis,utf-8
set fileformats=unix,dos,mac

"===========================================
" Turn off beep sound.
"===========================================
set vb t_vb=

"===========================================
" Cursor type
"===========================================
let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"

"===========================================
" key binding
"===========================================

"--- vidual mode ---
vnoremap * "zy:let @/ = @z<CR>n

"--- edit mode ---
nnoremap <C-l> $

" tab jump
nnoremap <C-n> :<c-u>tabnext<CR>
nnoremap <C-p> :<c-u>tabprevious<CR>
nnoremap <S-Tab> gt
nnoremap <Leader>t gt
nnoremap <Leader>T gT
"nnoremap <Leader>tn :tabnew<CR>

" search word
"nnoremap * *zz
"nnoremap # #zz
nnoremap * *N
nnoremap # #n

" window jump
nnoremap <Leader>ww <C-w>w
nnoremap <Leader>wh <C-w>wh
nnoremap <Leader>wk <C-w>wk
nnoremap <Leader>wj <C-w>wj
nnoremap <Leader>wl <C-w>wl

" window size vertical
nmap <C-w>- <C-w>-<C-w>
nmap <C-w>; <C-w>+<C-w>
nmap <Leader>w;    <C-w>;
nmap <Leader>w-    <C-w>-

" window size width
nmap <C-w>, <C-w><<C-w>
nmap <C-w>. <C-w>><C-w>
nmap <Leader>w.    <C-w>.
nmap <Leader>w,    <C-w>,

" ctags as like eclipse
" nnoremap <F3> <C-]>
nnoremap <F3> g<C-]>
" nnoremap <C-k> g<C-]>
nnoremap <expr> <C-k> 'tab sp<CR>:tjump ' . expand("<cword>") . '<CR>'
nnoremap <expr> <M-m> ':tab sp<CR>:tag ' . expand("<cword>") . '<CR>'
nnoremap <expr> <M-f> ':tab sp<CR>:tag ' . expand("<cfile>") . '<CR>'

"--- Insert mode ---
"move
"imap <C-j> <Down>
"imap <C-k> <Up>
"imap <C-h> <Left>
"imap <C-l> <Right>
"imap <C-w> <ESC>lwi
"imap <C-b> <ESC>bi
"imap <C-a> <ESC>0i
"escape
inoremap <C-j> <ESC>
snoremap <C-j> <ESC>
"imap <C-S-f> <ESC>l<C-f>i
"imap <C-S-b> <ESC>l<C-b>i

"insert line
inoremap <C-o> <ESC>o


"--- tmp ---
"map K "qp
"nmap K nvf<s#Response#declare namespace ws='http://ws.mm.nhm.nec.co.jp/'; //ws:getExtractJobBinaryResponse[1]/return[1]}<<ESC>
"nnoremap K /jdbc:oracle:thin:@${IP}:${PORT}:${SID}<CR>v37lsjdbc:oracle:thin:@${IP}:${PORT}/${SID}<ESC>

" ------------------
" Quick Run
" ------------------
nnoremap <silent> <Leader>q :QuickRun
nnoremap <silent> <Leader>e <C-w><C-w>:q<CR>
"let g:quickrun_config={'*': {'split': ''}}
set splitbelow
set splitright


" ------------------
" fuzzy finder
" ------------------
nnoremap <silent> <Leader>ff :<C-u>tabnew<CR>:tabmove<CR>:FufFile **/<CR>
nnoremap <expr> <Leader>j ':<C-u>tabnew<CR>:tabmove<CR>:FufFile **/' . expand("<cword>") . '<CR>'
"nnoremap <silent> <Leader>ff :FufFile **/<CR>
"nnoremap <silent> ;ff :FuzzyFinderFile<CR> " old fuzzyfinder

" ------------------
" NERDTree
" ------------------
nnoremap <Leader>n :NERDTreeToggle<CR>
let NERDTreeShowBookmarks=1


" ------------------
" back space effecte
" ------------------
set backspace=indent,eol,start
inoremap ^? ^H

" ===========================================
" vim color
" ===========================================
hi Search    ctermfg=black ctermbg=11
hi Visual    ctermbg=9
 
" ===========================================
" vim diff color
" ===========================================
hi DiffAdd    ctermfg=black ctermbg=2
hi DiffChange ctermfg=black ctermbg=3
hi DiffDelete ctermfg=black ctermbg=6
hi DiffText   ctermfg=black ctermbg=7

" ===========================================
" vim diff keybind
" ===========================================
nnoremap dn ]c
nnoremap dN [c

" ============================================
" completion color
" ============================================
set t_Co=256
set t_Sf=[3%dm
set t_Sb=[4%dm
 
hi Pmenu ctermbg=2
hi PmenuSel ctermbg=12
hi PmenuSbar ctermbg=0



" ============================================
" XML format
" ============================================
map <F5> <ESC>:exe ":silent 1,$!xmllint --format --recover - 2>/dev/null"<CR>


" ============================================
" pathogen plugin
" ============================================
"call pathogen#infect()

let Tlist_Ctags_Cmd = '/usr/local/bin/ctags'

" ============================================
" vim-quickhl plugin
" ============================================
nmap <Leader>m <Plug>(quickhl-manual-this)
xmap <Leader>m <Plug>(quickhl-manual-this)
nmap <Leader>M <Plug>(quickhl-manual-reset)
xmap <Leader>M <Plug>(quickhl-manual-reset)

" for vimdiff color
"highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=2
"highlight DiffDelete cterm=bold ctermfg=10 ctermbg=3
"highlight DiffChange cterm=bold ctermfg=10 ctermbg=6
"highlight DiffText   cterm=bold ctermfg=10 ctermbg=7


" ============================================
" Neobundle Settings. // deprecated
" ============================================
" bundleで管理するディレクトリを指定
"set runtimepath+=~/.vim/bundle/neobundle.vim/
" Required:
"call neobundle#begin(expand('~/.vim/bundle/'))

"neobundle自体をneobundleで管理
" NeoBundleFetch 'Shougo/neobundle.vim'
" NeoBundle 'mileszs/ack.vim'
" NeoBundle 'davidhalter/jedi-vim'
" NeoBundle 'vim-scripts/FuzzyFinder'
" NeoBundle 'vim-scripts/L9'
" NeoBundle 'vim-scripts/taglist.vim'
" NeoBundle 'vim-scripts/SQLUtilities'
" NeoBundle 'othree/vim-autocomplpop'
" NeoBundle 'kevinw/pyflakes-vim'
" NeoBundle 'thinca/vim-quickrun'
" NeoBundle 't9md/vim-quickhl'
" NeoBundle 'Align'
" NeoBundle 'rhysd/clever-f.vim'
" NeoBundle 'osyo-manga/vim-brightest'

" call neobundle#end()
" Required:
"filetype plugin on "

"未インストールのプラグインがある場合、インストールするかどうかを尋ねてくれるようにする設定"
"毎回聞かれると邪魔な場合もあるので、この設定は任意です
" NeoBundleCheck

" ============================================
" dein  // NeoBundleがdeprecatedになったのでdeinを使う
" ============================================
" プラグインが実際にインストールされるディレクトリ
let s:dein_dir = expand('~/.cache/dein')
" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vim がなければ github から落としてくる
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    let s:clone_opt = ""
    " 最新deinで使用しているv:t_xxxをvim7系はサポートしていないので1.0ブランチをcloneする
    if v:version < 800
        let s:clone_opt = "-b 1.0"
    endif
    execute '!git clone' s:clone_opt 'https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

" 設定開始
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " プラグインリストを収めた TOML ファイル
  " 予め TOML ファイル（後述）を用意しておく
  let g:rc_dir    = expand('~/.vim/rc')
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:neo_toml  = g:rc_dir . '/dein.neo.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

  " TOML を読み込み、キャッシュしておく
  call dein#load_toml(s:toml,      {'lazy': 0})
  
  if has('lua')
    call dein#load_toml(s:neo_toml,  {'lazy': 0})
  endif

  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  " 設定終了
  call dein#end()
  call dein#save_state()
endif

" もし、未インストールものものがあったらインストール
if dein#check_install()
  call dein#install()
endif

" ============================================
" Ag
" ============================================
let g:ackprg = "ag --nogroup --nocolor --column"
nnoremap <expr> <C-h> ':<C-u>tabnew<CR>:Ack ' . expand("<cword>") . '<CR>'

" For pyflakes color
highlight clear SpellBad
highlight SpellBad term=standout ctermfg=1 term=underline cterm=underline

" ============================================
" vim-easy-align
" ============================================
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" ============================================
" easymotion
" ============================================
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
nmap <Leader>s <Plug>(easymotion-s2)
nmap <Space> <Plug>(easymotion-s)


"--------------------------------------------------
" Python Format
"--------------------------------------------------
noremap <buffer> ,pp :call Autopep8()<CR>
noremap <buffer> ,pt <Esc>:call PythonTidy()<CR>
noremap <buffer> ,pf :call Pyflakes()<CR>

"--------------------------------------------------
" Python Autopep8
"--------------------------------------------------
function! Preserve(command)
    " Save the last search.
    let search = @/
    " Save the current cursor position.
    let cursor_position = getpos('.')
    " Save the current window position.
    normal! H
    let window_position = getpos('.')
    call setpos('.', cursor_position)
    " Execute the command.
    execute a:command
    " Restore the last search.
    let @/ = search
    " Restore the previous window position.
    call setpos('.', window_position)
    normal! zt
    " Restore the previous cursor position.
    call setpos('.', cursor_position)
    endfunction

function! Autopep8()
    call Preserve(':silent %!autopep8 -')
endfunction

"----------------------------------------------------------
" neocomplete or neocomplcacheの設定
"----------------------------------------------------------
if has('neocomplete.vim')
    " Vim起動時にneocompleteを有効にする
    let g:neocomplete#enable_at_startup = 1
    " smartcase有効化. 大文字が入力されるまで大文字小文字の区別を無視する
    let g:neocomplete#enable_smart_case = 1
    " 3文字以上の単語に対して補完を有効にする
    let g:neocomplete#min_keyword_length = 3
    " 区切り文字まで補完する
    let g:neocomplete#enable_auto_delimiter = 1
    " 1文字目の入力から補完のポップアップを表示
    let g:neocomplete#auto_completion_start_length = 1
    " バックスペースで補完のポップアップを閉じる
    inoremap <expr><BS> neocomplete#smart_close_popup()."<C-h>"

else
    let g:acp_enableAtStartup = 0
    let g:neocomplcache_enable_at_startup = 1
    let g:neocomplcache_enable_smart_case = 1
    let g:neocomplcache_min_syntax_length = 3
    let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

endif


"----------------------------------------------------------
" neosnippet
"----------------------------------------------------------
" エンターキーで補完候補の確定. スニペットの展開もエンターキーで確定・・・・・・
imap <expr><CR> neosnippet#expandable() ? "<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "<C-y>" : "<CR>"
" タブキーで補完候補の選択. スニペット内のジャンプもタブキーでジャンプ・・・・・・
imap <expr><TAB> pumvisible() ? "<C-n>" : neosnippet#jumpable() ? "<Plug>(neosnippet_expand_or_jump)" : "<TAB>"

let g:neosnippet#snippets_directory='~/.vim/neosnippets'

"----------------------------------------------------------
" vim-brightest: カーソル下のハイライトを変更
"----------------------------------------------------------
let g:brightest#highlight = {
\   "group"    : "DiffText",
\}
