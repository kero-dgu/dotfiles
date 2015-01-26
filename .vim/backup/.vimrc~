" Add paths  **************************************************
" C 関連の標準ライブラリへのパスを追加
augroup AddPaths
  autocmd!
  if has('win32') || has('win64')
    autocmd FileType c,cpp set path+=C:\pg\mingw64\x86_64-w64-mingw32\include\
  elseif has('mac')
    autocmd FileType c,cpp,objc set path+=/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/../lib/clang/6.0/include,/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/include,/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/include/c++/v1/,/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.10.sdk/usr/include,/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.10.sdk/System/Library/Frameworks\ (framework\ director)
  endif
augroup END


" Autocmd **************************************************
augroup EditNewFile
  autocmd!
  autocmd BufNewFile * echo 'This is new file'
augroup END


" Backup **************************************************
set backupdir=$HOME/.vim/backup  " バックアップファイル用のディレクトリ
set directory=$HOME/.vim/backup  " スワップファイル用のディレクトリ


" Colorscheme **************************************************
syntax on
set t_Co=256


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
inoremap {<Enter> {}<Left><CR><ESC><S-o>
inoremap [<Enter> []<Left><CR><ESC><S-o>
inoremap (<Enter> ()<Left><CR><ESC><S-o>


" Initialialization **************************************************
" vi 互換性を OFF
set nocompatible
" Windows では日本語入力ができなくなる
" set imdisable
" un~ ファイルを作成しない
set noundofile
" 改行時の自動コメントアウトを無効化
set formatoptions-=ro
" 保存時に行末の空白を自動で削除
autocmd BufWritePre * :%s/\s\+$//ge


" Keybind **************************************************
" Esc キーを割り当て
imap <C-j> <esc>
" C-j C-j でハイライト OFF
nnoremap <C-j><C-j> :<C-u>set nohlsearch<Return>
" 分割ウィンドウ時に移動を行う
noremap <C-H> <C-W>h
noremap <C-J> <C-W>j
noremap <C-K> <C-W>k
noremap <C-L> <C-W>l


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

NeoBundle 'Align'
NeoBundle 'Townk/vim-autoclose'
NeoBundle 'grep.vim'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'nathanaelkane/vim-indent-guides'
" color themes
NeoBundle 'tomasr/molokai'

" neocomplete - 補完候補を自動表示
if has('lua')   " Lua がないと neocomplete は使えない
  NeoBundle 'Shougo/neocomplete.vim'
  let g:neocomplete#enable_at_startup  = 1
  let g:neocomplete#enable_ignore_case = 1
  let g:neocomplete#enable_smart_case  = 1
  if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
  endif
  let g:neocomplete#keyword_patterns._ = '\h\w*'

  " neocomplete と clang_complete を併用するための設定
  let g:marching_enable_neocomplete = 1
  if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
  endif
  let g:neocomplete#force_overwrite_completefunc = 1
  let g:neocomplete#force_omni_input_patterns.c =
    \ '[^.[:digit:] *\t]\%(\.\|->\)'
  let g:neocomplete#force_omni_input_patterns.cpp =
    \ '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
  if has('mac')
    let g:neocomplete#force_omni_input_patterns.objc =
      \ '[^.[:digit:] *\t]\%(\.\|->\)'
    let g:neocomplete#force_omni_input_patterns.objcpp =
      \ '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
  endif
endif

" clang_complete - C/C++/Objective-C に特化した補完
if has('mac')
  NeoBundle 'tokorom/clang_complete'
  let g:clang_complete_auto=0  " neocomplete との競合を避けるため
  let g:clang_auto_select=0
  let g:clang_use_library=1
  let g:clang_debug=1
  if has('win32') || has('win64')
    let g:clang_library_path='C:\pg\LLVM\bin'
  elseif has('mac')
    let g:clang_library_path='/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib'
  endif
endif

" clang_complete-getopts-ios
if has('mac')
  NeoBundle 'tokorom/clang_complete-getopts-ios'
  let g:clang_complete_getopts_ios_default_options='-w -fblocks -fobjc-arc -D __IPHONE_OS_VERSION_MIN_REQUIRED=40300 -include ./**/*-Prefix.pch -F /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator8.1.sdk/System/Library/Frameworks -I /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator8.1.sdk/usr/include'
  let g:clang_complete_getopts_ios_sdk_directory = '/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator8.1.sdk'
  let g:clang_complete_getopts_ios_ignore_directories = ["^\.git", "\.xcodeproj"]
endif

" Syntaxs
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'digitaltoad/vim-jade'
NeoBundle 'groenewege/vim-less'

" caw.vim - コメントアウト
NeoBundle 'tyru/caw.vim'
nmap <Leader>c <Plug>(caw:I:toggle)
vmap <Leader>c <Plug>(caw:I:toggle)

" lightline.vim - statusline をカッコよく
NeoBundle 'itchyny/lightline.vim'
let g:lightline = {
  \ 'colorscheme': 'wombat',
  \ 'component': {
  \   'readonly': '%{&readonly?"\u2b64":""}',
  \ },
  \ }

" titanium-vim - Titanium mobile の補完
NeoBundle 'pekepeke/titanium-vim'

" taglist - ctags を利用したアウトライン
NeoBundle 'vim-scripts/taglist.vim'
set tags=tags
if has('win32') || has('win64')
  let Tlist_Ctags_Cmd = 'C:\pg\LLVM\lib\clang\3.5.0\lib\windows'
elseif has('mac')
  let Tlist_Ctags_Cmd = '/usr/local/bin/ctags'
endif
let Tlist_Show_One_File = 1
let Tlist_Use_Right_Window = 1
let Tlist_Exit_OnlyWindow = 1
map <silent> <leader>l :TlistToggle<CR>

NeoBundle 'vim-scripts/TagHighlight'

" vim-rooter - プロジェクトのルートディレクトリを見つけて移動するコマンドを実装
NeoBundle 'airblade/vim-rooter'
if !empty(neobundle#get('vim-rooter'))
  let g:rooter_use_lcd=1
  let g:rooter_patterns=['tags', '.tags', '.git', '.git/', '_darcs/', '.hg/', '.bzr/', 'Makefile', 'GNUMakefile', 'GNUmakefile', '.svn/']
endif

" Unite - ファイルの管理など
NeoBundle 'Shougo/unite.vim'
let g:vim_tags_project_tags_command = "/c/pg/Ctags/ec58j2w32bin/ctags58j2bin/ctags -R {OPTIONS} {DIRECTORY} 2>/dev/null"

" minibufexpl - バッファをタブのように管理
" NeoBundle 'fholgado/minibufexpl.vim'
" let g:miniBufExplSplitBelow=0        " Put new window above
" let g:miniBufExplMapWindowNavArrows=1
" let g:miniBufExplMapCTabSwitchBufs=1
" let g:miniBufExplModSelTarget=1
" let g:miniBufExplSplitToEdge=1

" neosnippet - スニペット
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
" SuperTab like snippets behavior.
"imap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
"smap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

" NERDTree - ファイルエクスプローラー
NeoBundle 'scrooloose/nerdtree'
let NERDTreeShowHidden=1    " 隠しファイルを表示する
let file_name=expand('%:p') " 引数なしで実行した時に、NERDTree を実行する
" デフォルトでツリーを表示する
"autocmd VimEnter * execute 'NERDTree'
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
NeoBundleCheck


" Search **************************************************
set incsearch    " インクリメンタルサーチを行う
set smartcase    " 検索時に大文字小文字を区別


" Syntaxs**************************************************
" Coffee-Script
" coffee ファイルタイプを設定
au BufRead,BufNewFile,BufReadPre *.coffee set filetype=coffee
" エラーがあったら別ウィンドウで表示
autocmd QuickFixCmdPost * nested cwindow | redraw!
" 保存時にコンパイル
" autocmd BufWritePost *.coffee silent CoffeeMake! -cb | cwindow | redraw!
" Ctrl-c で右ウィンドウにコンパイル結果を一時的に表示する
nnoremap <silent> <C-C> :CoffeeCompile vert <CR><C-w>h
" ==================================================

" Jade
autocmd BufNewFile,BufRead *.jade set filetype=jade
let g:quickrun_config['jade']={'command': 'jade', 'cmdopt': '-P', 'exec': ['%c &o < %s']}
" ==================================================

" LESS
autocmd BufRead,BufNewFile,BufReadPre *.less set filetype=less
" ==================================================

" Objective-C
let g:filetype_m = 'objc'
" ==================================================

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
