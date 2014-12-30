" Add paths  **************************************************
" C/C++ の標準ライブラリへのパスを追加
augroup c-path
  autocmd!
  autocmd FileType c set path+=C:\pg\mingw64\x86_64-w64-mingw32\include\
augroup END
augroup cpp-path
  autocmd!
  autocmd FileType cpp set path+=C:\pg\mingw64\x86_64-w64-mingw32\include\c++\
augroup END


" Backup **************************************************
set backupdir=$HOME/.vim/backup  " バックアップファイル用のディレクトリ
set directory=$HOME/.vim/backup  " スワップファイル用のディレクトリ


" Colorscheme **************************************************
syntax on
colorscheme Sunburst


" Clipboard **************************************************
set clipboard=unnamed  " クリップボードを連携


" Edit **************************************************
set nowrap    " 折り返し禁止

" Encoding
set encoding=utf-8
" encoding を utf-8 にすると文字化けするので, 下記を追加する
source $VIMRUNTIME/delmenu.vim
set langmenu=ja_jp.utf-8
source $VIMRUNTIME/menu.vim

" タブ・空白・改行の可視化
set list
set listchars=tab:>.,trail:_,eol:$,extends:>,precedes:<,nbsp:%

" Font
set guifont=Monaco:h9
set guifontwide=MeiryoKe_Gothic:h9
set antialias                         " アンチエイリアス


" Highlight **************************************************
set list
set showmatch                       " 対応する閉じカッコを強調表示
set hlsearch                        " 検索結果を強調表示
set cursorline                      " カレント行ハイライト

" 全角スペースをハイライト
function! ZenkakuSpace()
  highlight ZenkakuSpace cterm=reverse ctermfg=DarkMagenta gui=reverse guifg=DarkMagenta
endfunction
if has('syntax')
  augroup ZenkakuSpace
    autocmd!
    autocmd ColorScheme       * call ZenkakuSpace()
    autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
  augroup END
  call ZenkakuSpace()
endif


" Indent **************************************************
set autoindent
set smartindent


" Initialialization **************************************************
" vi 互換性を OFF
set nocompatible
" Windows では日本語入力ができなくなる
" set imdisable
" un~ ファイルを作成しない
set noundofile


" Keybind **************************************************
" Esc キーを割り当て
imap <C-j> <esc>
" C-j C-j でハイライト OFF
nnoremap <C-j><C-j> :<C-u>set nohlsearch<Return>


" NeoBundle **************************************************
if has('vim_starting')
  if &compatible
    set nocompatible
  endif
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#begin(expand('~/.vim/bundle/'))
" ここからプラグインを記述 ==============================
NeoBundleFetch 'Shougo/neobundle.vim'   " NeoBundle 自身を管理する場合は NeoBundleFetch とする

" neocomplete - 補完候補を自動表示
if has('lua')   " Lua がないと neocomplete は使えない
  NeoBundle 'Shougo/neocomplete.vim'
  let g:neocomplete#enable_at_startup = 1         " 補完を有効にする
  let g:neocomplete#skip_auto_complete_time = ""  " 補完に時間がかかってもスキップしない
endif

NeoBundle 'Townk/vim-autoclose'
NeoBundle 'grep.vim'                  " grep 検索
NeoBundle 'scrooloose/syntastic'      " シンタックスエラーのチェック?

" minibufexpl - バッファをタブのように管理
NeoBundle 'fholgado/minibufexpl.vim'
" 分割ウィンドウ時に移動を行う
noremap <C-H> <C-W>h
noremap <C-J> <C-W>j
noremap <C-K> <C-W>k
noremap <C-L> <C-W>l

" neosnippet - スニペット
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'

" NERDTree - ファイルエクスプローラー
NeoBundle 'scrooloose/nerdtree'
let NERDTreeShowHidden=1    " 隠しファイルを表示する
let file_name=expand('%:p') " 引数なしで実行した時に、NERDTree を実行する
" NERDTree の表示を切り替え
nnoremap <silent><C-e> :NERDTreeToggle<CR>

" QuickRun - プログラムを実行
NeoBundle 'thinca/vim-quickrun'
set splitbelow  " 新しいウィンドウを下に開く
let g:quickrun_config = {'*': {'hook/time/enable': '1'},}   " 実行速度を表示

" vim-altr - ヘッダとソースファイルの切り替え
NeoBundle 'kana/vim-altr'
nnoremap <Leader>a <Plug>(altr-forward)

" ここまで ==============================
call neobundle#end()
filetype plugin indent on
syntax on
colorscheme Sunburst
NeoBundleCheck


" Search **************************************************
set incsearch    " インクリメンタルサーチを行う
set smartcase    " 検索時に大文字小文字を区別


" Tab **************************************************
set expandtab  " タブの代わりに空白文字を挿入する
set shiftwidth=2
set tabstop=2
set smarttab      " 行頭の余白内で Tab を打ち込むと 'shiftwidth' の文だけインデントする


" View **************************************************
set title
set number
set showcmd             " コマンドライン補完を表示
set guioptions-=T       " ツールバーを非表示にする
set guioptions-=m       " メニューバーを非表示にする
set laststatus=2        " ステータスバーを表示
set ruler               " ルーラーの表示
set colorcolumn=80,100  " 80行目に印が出る
" ステータスラインに文字コードと改行文字を表示する
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P
