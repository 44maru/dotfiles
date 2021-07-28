syntax on

set cursorline

" Enable Alt + m as <M-m>
execute "set <M-m>=\em"
" Enable Alt + f as <M-f>
execute "set <M-f>=\ef"
" Enable Alt + w as <M-w>
execute "set <M-w>=\ew"
" Enable Alt + n as <M-n>
execute "set <M-n>=\en"

let mapleader = ";"

"===================
" Indent
"===================
"retab command
"if you set expandtab   --> convert tab to space.
"if you set noexpandtab --> convert space to tab.

set ts=4 "tabstop       タブを含むファイルを開いた際, タブを何文字の空白に変換するか
set sw=4 "shiftwidth    自動インデントで入る空白数
set et   "expandtab     convert tab to space.
"set autoindent
"
" ファイルタイプの検索を有効にする
filetype plugin on
" ファイルタイプに合わせたインデントを利用
filetype indent on

" https://qiita.com/ymiyamae/items/06d0f5ce9c55e7369e1f
" sw=softtabstop, sts=shiftwidth, ts=tabstop, et=expandtab
autocmd FileType sh         setlocal sw=2 sts=2 ts=2 et

set hlsearch
"set number

"===================
" Register
"===================
" Paste from yank regsiter
"nnoremap P "0p

"===================
" Mouse ON/OFF
"===================
nnoremap m :set mouse=a<CR>
nnoremap <S-m> :set mouse-=a<CR> 
"set mouse=a
"set mouse=n
" mouse ON時に、windowを幅をマウスで調整するには下記設定が必要
set ttymouse=xterm2

"===============================================
" get gitlab url of current edit file
"===============================================
" need copy ~/.zshrc to ~/.zshenv to execute user custom command.
nnoremap <expr> <Leader>g ':!giturl ' . expand("%") . '<CR>'
nnoremap <expr> <Leader>G ':!githuburl ' . expand("%") . '<CR>'

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
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis
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

"--- normal mode ---
nnoremap <C-l> $
nnoremap tt :cd %:h<CR>:term<CR>

"--- search word ---
nnoremap * *N
nnoremap # #n

"-----------------
" buffer
"-----------------
set hidden
nnoremap <C-n> :bn<CR>
nnoremap <C-p> :bp<CR>
nnoremap Q :bp<bar>bd #<CR>

"-----------------------
" Window split
"-----------------------
" window jump prefix (Alt + w)
nnoremap <M-w> <C-w>w

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

"-----------------------
" ctags
"-----------------------
set tags=tags;
" ctags as like eclipse
nnoremap <F3> g<C-]>
nnoremap <expr> <C-k> ':tjump ' . expand("<cword>") . '<CR>'
nnoremap <expr> <M-m> ':tag ' . expand("<cword>") . '<CR>'
nnoremap <expr> <M-f> ':tag ' . expand("<cfile>") . '<CR>'

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
nnoremap <silent> <Leader>ff :NERDTreeClose<CR>:FufFile **/<CR>
nnoremap <expr> <Leader>j ':NERDTreeClose<CR>:FufFile **/' . expand("<cword>") . '<CR>'
xnoremap <Leader>j :call <SID>search_file()<CR>

function! s:search_file()
  silent normal gv"zy
  silent execute ":NERDTreeClose"
  silent execute ":FufFile **/" . @z
endfunction


" ------------------
" NERDTree
" ------------------
"nnoremap <Leader>n :NERDTreeToggle<CR>
" 新しいtabで開いたときにツリーを同期(vim-nerdtree-tabsプラグイン)
nnoremap <Leader>n :NERDTreeTabsToggle<CR>
" 現在開いているファイルに移動してTreeを再表示
nnoremap <Leader>N :CD<CR>:NERDTree<CR>
" Tree内の現在開いているファイルへカーソル移動
nnoremap <M-n> :NERDTreeFind<CR>

" vim起動時にツリーを表示
let g:nerdtree_tabs_open_on_console_startup=1
" NERDTree内で、:Bookmark コマンドで登録できる
let NERDTreeShowBookmarks=1
" Enterで新しいtabで開く
"let NERDTreeMapOpenInTab='<ENTER>'
" マウスでツリー操作(set moues=aが事前に必要)
let g:NERDTreeMouseMode=2

" 現在開いているファイルに移動するためのコマンド定義
command! -nargs=? -complete=dir -bang CD  call s:ChangeCurrentDir('<args>', '<bang>')
function! s:ChangeCurrentDir(directory, bang)
    if a:directory == ''
        lcd %:p:h
    else
        execute 'lcd' . a:directory
    endif

    if a:bang == ''
        pwd
    endif
endfunction


" Memo
" Shift + i --> 隠しファイル表示

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
nmap <Leader>m <Plug>(quickhl-manual-this-whole-word)
xmap <Leader>m <Plug>(quickhl-manual-this-whole-word)
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
nnoremap <expr> <C-h> ':Ack ' . expand("<cword>") . '<CR>'

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
" Enable snipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 1
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
" エンターキーで補完候補の確定. スニペットの展開もエンターキーで確定・・・・・・
" なぜかvimrcをリロードしないと有効にならない
imap <expr><CR> neosnippet#expandable() ? "<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "<C-y>" : "<CR>"
" タブキーで補完候補の選択. スニペット内のジャンプもタブキーでジャンプ・・・・・・
imap <expr><TAB> pumvisible() ? "<C-n>" : neosnippet#jumpable() ? "<Plug>(neosnippet_expand_or_jump)" : "<TAB>"
smap <expr><TAB> pumvisible() ? "<C-n>" : neosnippet#jumpable() ? "<Plug>(neosnippet_expand_or_jump)" : "<TAB>"

let g:neosnippet#snippets_directory='~/.vim/neosnippets'

"----------------------------------------------------------
" vim-brightest: カーソル下のハイライトを変更
"----------------------------------------------------------
let g:brightest#highlight = {
\   "group"    : "DiffText",
\}

"----------------------------------------------------------
" vim-autoformat
" https://github.com/briemens/vim-autoformat
"----------------------------------------------------------
au BufWrite *.sh :Autoformat
au BufWrite *.py :Autoformat
au BufWrite *.go :Autoformat

let g:formatdef_my_custom_sh = '"shfmt -i 2"'
let g:formatters_sh = ['my_custom_sh']

let g:formatdef_autopep8 = '"autopep8 - --aggressive --aggressive"'
let g:formatters_python = ['autopep8']

"----------------------------------------------------------
" taglist.vim
"----------------------------------------------------------
" TagList ON/OFF
nnoremap <Leader>t :Tlist<CR>
" TagListをVim起動時に開く
"let Tlist_Auto_Open = 1
" タグに色をつける
let Tlist_Auto_Highlight_Tag = 0
" 新規ファイルを開いた時に自動的にタグリストに追加する
let Tlist_Auto_Update = 1
" タグを選択時に、画面遷移後にタグリストを閉じない
let Tlist_Close_On_Select = 0
" デフォルト表示かコンパクト表示か
" 0(デフォルト) または 1(コンパクト)
let Tlist_Compact_Format = 0
" ctagsコマンドの場所 パスが通っている場合はctagだけでOK
let Tlist_Ctags_Cmd = "ctags"
" タグのプロトタイプを表示する
let Tlist_Display_Prototype = 1
" C++のようにスコープを持つタグで、スコープを表示する
let Tlist_Display_Tag_Scope = 1
" Foldカラムを表示するか表示しないか。狭い場所に表示させたい時は非表示に
" 0(表示しない) または 1(表示する)
let Tlist_Enable_Fold_Column = 1
" タグリストだけが表示されているときに自動的にVimを終了する
let Tlist_Exit_OnlyWindow = 1
" ファイルが非アクティブのとき自動的にタグリストを閉じる
let Tlist_File_Fold_Auto_Close = 1
" TlistToggleコマンド入力時、フォーカスをタグリストに移動する
let Tlist_GainFocus_On_ToggleOpen = 1
" 自動ハイライト表示
let Tlist_Highlight_Tag_On_BufEnter = 1
" ウィンドウ幅を変更出来ない場合や幅を固定したい場合
" let Tlist_Inc_Winwidth = 0
" function variable classなど区分けがこの値より多い場合、分割して表示する
let Tlist_Max_Submenu_Items = 25
" タグ名の最大幅
let Tlist_Max_Tag_Length = 10
" TagListが自動的に動作し、新たな関数や変数が追加した時に対応する
let Tlist_Process_File_Always = 1
" GUI Vimを使用した場合、メニューを表示する
let Tlist_Show_Menu = 1
" Vimのバッファにある全てのファイルのタグを表示するか、カレントバッファのタグだけを表示するか
" 1(カレントバッファのみ)
let Tlist_Show_One_File = 1
" どの順番でソートを行うか
" 設定しない(定義順) または name(アルファベット順)
let Tlist_Sort_Type = "name"
" 画面を上下に分割してタグを表示するか
" 設定しない(左右に分割) または 1(上下に分割)
let Tlist_Use_Horiz_Window = 0
" タグ画面を右に表示するか
" 設定しない(左に表示) または 1(右に表示)
let Tlist_Use_Right_Window = 1
" マウスでタグをシングルクリックして、対象場所へ遷移する
let Tlist_Use_SingleClick = 1
" 画面を上下に分割した場合の、タグ画面の初期高さ
let Tlist_WinHeight = 20
" 画面を左右に分割した場合の、タグ画面の初期幅
let Tlist_WinWidth = 40


