
" .vimrcの編集
nnoremap <F8> :e $MYVIMRC<CR>
" .vimrcのリロード
nnoremap <F9> :source $MYVIMRC<CR>

set nocompatible    " vi互換しない


"*****************************************************************************
"" Vim-Plug core
"*****************************************************************************
let vimplug_exists=expand('~/.vim/autoload/plug.vim')
let curl_exists=expand('curl')

let g:vim_bootstrap_langs = "html,javascript,python"
let g:vim_bootstrap_editor = "vim"				" nvim or vim
let g:vim_bootstrap_theme = "molokai"
let g:vim_bootstrap_frams = ""

if !filereadable(vimplug_exists)
  if !executable(curl_exists)
    echoerr "You have to install curl or first install vim-plug yourself!"
    execute "q!"
  endif
  echo "Installing Vim-Plug..."
  echo ""
  silent exec "!"curl_exists" -fLo " . shellescape(vimplug_exists) . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  let g:not_finish_vimplug = "yes"

  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif



" Required
call plug#begin(expand('~/.vim/plugged'))

"*****************************************************************************
"" Plug install packages
"" to install manually, call :PlugInstall
""
"" to remove, call :PlugClean
"" to update, call :PlugUpdate
"*****************************************************************************
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/fern-hijack.vim'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'othree/yajs.vim', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'maxmellon/vim-jsx-pretty'

Plug 'Vimjas/vim-python-pep8-indent'
Plug 'leafgarland/typescript-vim'

" Plug 'scrooloose/nerdtree'
" Plug 'jistr/vim-nerdtree-tabs'
" Plug 'tpope/vim-commentary'
" Plug 'tpope/vim-fugitive'
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
" Plug 'airblade/vim-gitgutter'
" Plug 'vim-scripts/grep.vim'
" Plug 'vim-scripts/CSApprox'
" Plug 'Raimondi/delimitMate'
" Plug 'majutsushi/tagbar'
" Plug 'dense-analysis/ale'
" Plug 'Yggdroot/indentLine'
" Plug 'editor-bootstrap/vim-bootstrap-updater'
" Plug 'tpope/vim-rhubarb' " required by fugitive to :Gbrowse
" Plug 'tomasr/molokai'


"" Include user's extra bundle
if filereadable(expand("~/.vimrc.local.bundles"))
  source ~/.vimrc.local.bundles
endif

call plug#end()

" Required
filetype plugin indent on



"*****************************************************************************
"" Fern
"*****************************************************************************
" Disable netrw
let g:loaded_netrw  = 1
let g:loaded_netrwPlugin = 1
let g:loaded_netrwSettings = 1
let g:loaded_netrwFileHandlers = 1


function! FernStart() abort
  :Fern . -drawer -width=40 -toggle -keep -reveal=%<CR>
endfunction

function! FernInit() abort
  nmap <buffer><expr>
        \ <plug>(fern-my-open-expand-collapse)
        \ fern#smart#leaf(
        \   "\<plug>(fern-action-open)",
        \   "\<plug>(fern-action-expand)",
        \   "\<plug>(fern-action-collapse)",
        \)
  nmap <buffer> <CR> <plug>(fern-my-open-expand-collapse)

  nmap <buffer> n <plug>(fern-action-new-path)
  nmap <buffer> d <Plug>(fern-action-remove)
  nmap <buffer> m <Plug>(fern-action-move)
  nmap <buffer> M <Plug>(fern-action-rename)
  nmap <buffer> c <Plug>(fern-action-copy)
  nmap <buffer> ! <Plug>(fern-action-hidden:toggle)
  nmap <buffer> R <Plug>(fern-action-reload)
  nmap <buffer> * <Plug>(fern-action-mark:toggle)
  nmap <buffer> b <Plug>(fern-action-open:split)
  nmap <buffer> v <Plug>(fern-action-open:vsplit)
  nmap <buffer> t <Plug>(fern-action-open:tabedit)
  nmap <buffer><nowait> < <Plug>(fern-action-leave)
  nmap <buffer><nowait> > <Plug>(fern-action-enter)
endfunction

" Custom settings and mappings.
let g:fern#disable_default_mappings = 1

" FernのON/OFF
nnoremap <F2> :call FernStart()<CR>

" vim開始時にON
augroup MyFernStartup
  autocmd!
  autocmd vimenter * ++nested call FernStart()
augroup End

augroup FernGroup
  autocmd!
  autocmd FileType fern call FernInit()
augroup End



" " -------------------------------------
" " カラースキームを確認する関数
" " http://cohama.hateblo.jp/entry/2013/08/11/020849
" " -------------------------------------
" function! s:get_syn_id(transparent)
"   let synid = synID(line("."), col("."), 1)
"   if a:transparent
"     return synIDtrans(synid)
"   else
"     return synid
"   endif
" endfunction
" function! s:get_syn_attr(synid)
"   let name = synIDattr(a:synid, "name")
"   let ctermfg = synIDattr(a:synid, "fg", "cterm")
"   let ctermbg = synIDattr(a:synid, "bg", "cterm")
"   let guifg = synIDattr(a:synid, "fg", "gui")
"   let guibg = synIDattr(a:synid, "bg", "gui")
"   return {
"         \ "name": name,
"         \ "ctermfg": ctermfg,
"         \ "ctermbg": ctermbg,
"         \ "guifg": guifg,
"         \ "guibg": guibg}
" endfunction
" function! s:get_syn_info()
"   let baseSyn = s:get_syn_attr(s:get_syn_id(0))
"   echo "name: " . baseSyn.name .
"         \ " ctermfg: " . baseSyn.ctermfg .
"         \ " ctermbg: " . baseSyn.ctermbg .
"         \ " guifg: " . baseSyn.guifg .
"         \ " guibg: " . baseSyn.guibg
"   let linkedSyn = s:get_syn_attr(s:get_syn_id(1))
"   echo "link to"
"   echo "name: " . linkedSyn.name .
"         \ " ctermfg: " . linkedSyn.ctermfg .
"         \ " ctermbg: " . linkedSyn.ctermbg .
"         \ " guifg: " . linkedSyn.guifg .
"         \ " guibg: " . linkedSyn.guibg
" endfunction
" command! SyntaxInfo call s:get_syn_info()
" " -------------------------------------

set cursorline " カーソルラインの強調表示を有効化
set number      " 行番号を表示

" [Backspace] で既存の文字を削除できるように設定
"  start - 既存の文字を削除できるように設定
"  eol - 行頭で[Backspace]を使用した場合上の行と連結
"  indent - オートインデントモードでインデントを削除できるように設定
set backspace=start,eol,indent

" 特定のキーに行頭および行末の回りこみ移動を許可する設定
"  b - [Backspace]  ノーマルモード ビジュアルモード
"  s - [Space]      ノーマルモード ビジュアルモード
"   - [→]          ノーマルモード ビジュアルモード
"  [ - [←]          挿入モード 置換モード
"  ] - [→]          挿入モード 置換モード
"  ~ - ~            ノーマルモード
set whichwrap=b,s,[,],,~

" 行末の空白削除
autocmd BufWritePre * :%s/\s\+$//ge

" カラースキーム
colorscheme molokai
set t_Co=256
set background=dark

" カラースキームを一部変更 -----
autocmd ColorScheme * highlight Cursor ctermfg=28 ctermbg=140  " カーソル
autocmd ColorScheme * highlight CursorLine term=underline cterm=underline ctermfg=227 ctermbg=233    " カーソル行
autocmd ColorScheme * highlight Search ctermfg=17 ctermbg=213     " 検索結果をハイライト
autocmd ColorScheme * highlight Visual ctermbg=237    " Visualモード選択色

" シンタックスハイライト有効化 (背景黒向け。白はコメントアウトされている設定を使用)
syntax enable

" クリップボード連携
set clipboard+=unnamed


" 文字コード関連 -----
set encoding=utf-8              " 文字コード
scriptencoding utf-8            " マルチバイト文字設定
set fileencoding=utf-8          " 保存時文字コード
set fileencodings=utf-8,sjis,euc-jp     " 文字コード自動判別
set fileformats=unix,dos,mac    " 改行コード自動判別
"set ambiwidth=double           " □などの崩れ対策

" tagsファイル設定
set tags=.tags;$HOME      " ホームディレクトリまで遡って探す

" タブ・インデント -----
set expandtab   "タブ入力を複数の空白入力に置き換える
set tabstop=2   "タブ文字幅
set shiftwidth=2       "自動インデント幅
set autoindent  "オートインデント
set smartindent "改行時に前の行のインデントを考慮する

set listchars=tab:>.
set list

set ruler   "カーソルの行列数を表示

" 新しいウィンドウを右に開く
set splitright

" ステータスラインを表示
set laststatus=2

" ステータスラインの内容
set statusline=%F%m%r%h%w\%=[TYPE=%Y]\[FORMAT=%{&ff}]\[ENC=%{&fileencoding}]\[LOW=%l/%L]

" 検索 -----
""set incsearch         " インクリメンタル検索を有効化
set ignorecase          " 検索の大文字小文字を区別しない
set smartcase           " 検索パターンに大文字を含む場合は大文字小文字を区別する
set hlsearch            " 検索キーワードをハイライト
nnoremap <silent><f3> :<C-u>set nohlsearch!<CR>     " F3で検索結果ハイライト表示を切り替え

set wildmenu wildmode=list:full     " コマンド補完時の一覧表示機能有効化

" 自動的にファイルを読み込むパスを設定 ~/.vim/userautoload/*vim
set runtimepath+=$HOME/.vim
runtime! userautoload/*.vim


" バックアップを作成しない
set nobackup

" vim外部で変更されたときに自動的に読み込み
set autoread

" swapファイルを作成しない
set noswapfile

" ヤンクをクリップボードに
set clipboard+=unnamed

" タブ移動
" nnoremap <C-n> gt
"  nnoremap <C-p> gT

nnoremap s <Nop>
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sH <C-w>H
nnoremap sn gt
nnoremap sp gT
nnoremap sr <C-w>r
nnoremap s= <C-w>=
nnoremap sw <C-w>w
nnoremap so <C-w>_<C-w>|
nnoremap sO <C-w>=
nnoremap sN :<C-u>bn<CR>
nnoremap sP :<C-u>bp<CR>
nnoremap st :<C-u>tabnew<CR>
nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>
nnoremap sq :<C-u>q<CR>
nnoremap sQ :<C-u>bd<CR>
nnoremap <Space>h <C-w><
nnoremap <Space>l <C-w>>
nnoremap <Space>j <C-w>-
nnoremap <Space>k <C-w>+

" Unite
" noremap <C-U><C-B> :Unite buffer<CR>
" noremap <C-U><C-F> :UniteWithBufferDir -buffer-name=files file<CR>
" noremap <C-U><C-Y> :Unite -buffer-name=register register<CR>

" " NERDTree
" nnoremap <f2> :NERDTreeToggle<CR>
"
" " NERDTreeで^Gの表示を消す（デリミタを変更）
" let g:NERDTreeNodeDelimiter = "\u00a0"

" QuickFixListを新しいタブで開く
autocmd QuickFixCmdPost vimgrep tab cwindow

" viでは読み込まない ここから
if 1

  " マウス機能有効化
  "set mouse=a

  " dein
  if &compatible
    set nocompatible
  endif

"   " dein ディレクトリ
"   let s:dein_dir = expand('~/.cache/dein')
"   " dein.vimの実体があるディレクトリ
"   let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
"
"   " deinのインストール確認 なければCloneする
"   if &runtimepath !~# '/dein.vim'
"     if !isdirectory(s:dein_repo_dir)
"       execute '!git clone https://github.com/Shougo/dein.vim -b 1.0' s:dein_repo_dir
"     endif
"     execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
"   endif
"
"   if dein#load_state(s:dein_dir)
"     call dein#begin(s:dein_dir)
"
"     call dein#add('Shougo/dein.vim')
"
"     call dein#add('Shougo/vimproc.vim', {
"           \'build': {
"           \'mac'     : 'make -f make_mac.mak',
"           \'linux'   : 'make',
"           \'unix'    : 'gmake'
"           \}
"           \})
"
"     call dein#add('Shougo/neocomplete.vim')
"     call dein#add('Shougo/neosnippet')
"     call dein#add('Shougo/neosnippet-snippets')
"     call dein#add('Shougo/unite.vim')
"     call dein#add('Shougo/vimshell')
"     call dein#add('nikvdp/ejs-syntax')
"     call dein#add('scrooloose/nerdtree')
"     call dein#add('posva/vim-vue')
"     call dein#add('othree/yajs.vim')
"     call dein#add('mrk21/yaml-vim')
"
"     " fzf
"     if executable('rg')
"       call dein#add('junegunn/fzf', { 'build': './install --all', 'merged': 0 })
"       call dein#add('junegunn/fzf.vim', { 'depends': 'fzf' })
"     endif
"
"     call dein#end()
"     call dein#save_state()
"   endif


"   filetype plugin indent on
"
"   " grep use ripgrep
"   if executable('rg')
"     set grepprg='rg\ --vimgrep\ --hidden\ --ignore-case'
"     set grepformat=%f:%l:%c:%m
"   endif
"
"   " ファイルタイプ
"   au BufNewFile,BufRead *.jbuilder set filetype=ruby
"   au BufNewFile,BufRead *.ejs set filetype=html
"
"   " NERDTreeを常に起動
"   let g:NERDTreeShowBookmarks=1
"   if !argc()
"     autocmd vimenter * NERDTree
"   endif

  " viでは読み込まない ここまで
endif

