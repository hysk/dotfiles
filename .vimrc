" vi互換OFF    
set nocompatible

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

" カーソル行カラー変更
autocmd ColorScheme * highlight CursorLine term=underline cterm=underline ctermfg=227 ctermbg=233

" カラースキーマ
colorscheme molokai
" let g:molokai_original = 1
set t_Co=256
set background=dark

" シンタックスハイライト有効化 (背景黒向け。白はコメントアウト
" されている設定を使用)
syntax enable
" highlight Normal ctermbg=black ctermfg=grey
" highlight StatusLine term=none cterm=none ctermfg=black ctermbg=grey
" highlight CursorLine term=none cterm=none ctermfg=none ctermbg=darkgray

""set nohlsearch " 検索キーワードをハイライトしないように設定
set cursorline " カーソルラインの強調表示を有効化

" 行番号を表示
set number

" タブ入力を複数の空白入力に置き換える 
set expandtab

" タブ文字幅
set tabstop=4

" 自動インデント幅
set shiftwidth=4

" オートインデント
set autoindent
set smartindent

" カーソルの行列数を表示
set ruler

" 新しいウィンドウを右に開く
set splitright

" ステータスラインを表示
set laststatus=2

" ステータスラインの内容
set statusline=%F%m%r%h%w\%=[TYPE=%Y]\[FORMAT=%{&ff}]\[ENC=%{&fileencoding}]\[LOW=%l/%L]

" インクリメンタル検索を有効化
""set incsearch

" 補完時の一覧表示機能有効化
set wildmenu wildmode=list:full

" 自動的にファイルを読み込むパスを設定 ~/.vim/userautoload/*vim
set runtimepath+=$HOME/.vim
runtime! userautoload/*.vim

" 改行コード
set fileformats=unix,dos,mac

" 文字コード
set encoding=utf-8

" 文字コード自動判別
set fileencodings=utf-8,sjis,euc-jp

" バックアップを作成しない
set nobackup

" vim外部で変更されたときに自動的に読み込み
set autoread

" swapファイルを作成しない
set noswapfile

" 検索の大文字小文字
set ignorecase
set smartcase

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
noremap <C-U><C-B> :Unite buffer<CR>
noremap <C-U><C-F> :UniteWithBufferDir -buffer-name=files file<CR>
noremap <C-U><C-R> :Unite file_mru<CR>
noremap <C-U><C-Y> :Unite -buffer-name=register register<CR>

" NERDTree
nnoremap <f2> :NERDTreeToggle<CR>


"mstertestmastertest

" viでは読み込まない ここから
if 1

" マウス機能有効化
set mouse=a


" dein
if &compatible
    set nocompatible
endif
set runtimepath^=~/.vim/bundle/dein.vim/

call dein#begin(expand('~/.cache/dein'))

call dein#add('Shougo/dein.vim')

call dein#add('Shougo/vimproc.vim', {
                        \'build': {
                        \'mac'     : 'make -f make_mac.mak',
                        \'linux'   : 'make',
                        \'unix'    : 'gmake'
                        \}
                        \})

call dein#add('Shougo/neocomplete.vim')
call dein#add('Shougo/neomru.vim')
call dein#add('Shougo/neosnippet')
call dein#add('Shougo/neosnippet-snippets')
call dein#add('Shougo/unite.vim')
call dein#add('Shougo/vimshell')
call dein#add('scrooloose/nerdtree')

call dein#end()

filetype plugin indent on

if executable('ag')
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
    let g:unite_source_grep_recursive_opt = ''
endif


" ファイルタイプ
au BufNewFile,BufRead *.jbuilder setf ruby

" NERDTreeを常に起動
let g:NERDTreeShowBookmarks=1
if !argc()
    autocmd vimenter * NERDTree
endif

" viでは読み込まない ここまで
endif

