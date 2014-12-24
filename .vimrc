" Autocommand **************************************************


" Backup **************************************************
set backupdir=$HOME/.vim/backup  " バックアップファイル用のディレクトリ
set directory=$HOME/.vim/backup  " スワップファイル用のディレクトリ


" Clipboard **************************************************
set clipboard=unnamed  " クリップボードを連携


" Edit **************************************************
set nowrap    " 折り返し禁止

" Encoding
set encoding=utf-8

" タブ・空白・改行の可視化
set list
set listchars=tab:>.,trail:_,eol:↲,extends:>,precedes:<,nbsp:%

" Font
set guifont=Monaco\ 11.5
colorscheme Sunburst


" Highlight **************************************************
syntax on
set list
set listchars=tab:>.,trail:_,eol:↲  
set showmatch                       " 対応する閉じカッコを強調表示
set hlsearch                        " 検索結果を強調表示
set cursorline                      " カレント業ハイライト


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
set nocompatible  " vi 互換性を OFF


" Keybind **************************************************
" Esc キーを割り当て
imap <C-j> <esc>
" C-j C-j でハイライト OFF
nnoremap <C-j><C-j> :<C-u>set nohlsearch<Return>
" NERDTree の表示を切り替え
nnoremap <silent><C-e> :NERDTreeToggle<CR>
" 分割ウィンドウ時に移動を行う
noremap <C-H> <C-W>h
noremap <C-J> <C-W>j
noremap <C-K> <C-W>k
noremap <C-L> <C-W>l
" caw.vim でコメント化の切り替え
nmap \c <Plug>(caw:I:toggle)
vmap \c <Plug>(caw:I:toggle)
nmap \C <Plug>(caw:I:uncomment)
vmap \C <Plug>(caw:I:uncomment)


" NeoBundle **************************************************
" NeoBundle インストールされていない or プラグインの初期化に失敗した時の処理
function! s:WithoutBundles()
  colorsheme Sunburst
endfunction

" NeoBundle によるプラグインのロードと各プラグインの初期化
function! s:LoadBundles()
  " 読み込むプラグインの設定
  NeoBundleFetch 'Shougo/neobundle.vim'   " NeoBundle 自身を管理する場合は NeoBundleFetch とする
  NeoBundle 'tpope/vim-surround'          " 選択範囲を括弧などで囲む

  " neocomplete - 補完候補を自動表示
  if has('lua')   " Lua がないと neocomplete は使えない
    NeoBundle 'Shougo/neocomplete.vim'
    let g:neocomplete#enable_at_startup = 1         " 補完を有効にする
    let g:neocomplete#skip_auto_complete_time = ""  " 補完に時間がかかってもスキップしない
  endif

  " NERDTree - ファイルエクスプローラー
  NeoBundle 'scrooloose/nerdtree'
  let NERDTreeShowHidden=1    " 隠しファイルを表示する
  let file_name=expand('%:p') " 引数なしで実行しhた時に、NERDTree を実行する

  NeoBundle 'Townk/vim-autoclose'
  NeoBundle 'mattn/emmet-vim'

  " QuickRun - プログラムを実行
  NeoBundle 'thinca/vim-quickrun'
  set splitbelow  " 新しいウィンドウを下に開く
  let g:quickrun_config = {'*': {'hook/time/enable': '1'},}   " 実行速度を表示

  NeoBundle 'fholgado/minibufexpl.vim'  " バッファをタブで管理する
  NeoBundle 'grep.vim'                  " grep 検索
  NeoBundle 'scrooloose/syntastic'      " シンタックスエラーのチェック?
  NeoBundle 'tyru/caw.vim'              " 素早くコメントアウト
endfunction

" NeoBundle がインストールされているなら LoadBundles() を呼び出す, インストールされていないなら WithoutBundles() を呼び出す
function! s:InitNeoBundle()
  if isdirectory(expand("~/.vim/bundle/neobundle.vim/"))
    filetype plugin indent off
    if has('vim_starting')
      set runtimepath+=~/.vim/bundle/neobundle.vim/
    endif
    try
      call neobundle#begin(expand('~/.vim/bundle/'))
      call s:LoadBundles()
      call neobundle#end()
    catch
      call s:WithoutBundles()
    endtry
  else
    call s:WithoutBundles()
  endif

  filetype indent on
  syntax on
endfunction
call s:InitNeoBundle()


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
set laststatus=2        " ステータスバーを表示
set ruler               " ルーラーの表示
set colorcolumn=80,100  " 80行目に印が出る
" ステータスラインに文字コードと改行文字を表示する
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P
