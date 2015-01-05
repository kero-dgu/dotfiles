" 恐らく .gvimrc でデフォルトで設定されているものによって .vimrc の設定が上書きされてしまっている
" 上書きされているものだけを, こちらに記述することで Linux や OSX と .vimrc を統一できる
colorscheme Sunburst
set guifont=Monaco:h10:w5
set guifontwide=MeiryoKe_Gothic:h10:w5
set antialias                         " アンチエイリアス


" Window **************************************************
" Window のサイズと位置を保存
let g:save_window_file=expand('~/.vim/.vimwinpos')
augroup SaveWindow
  autocmd!
  autocmd VimLeavePre * call s:save_window()
  function! s:save_window()
    let options = [
      \ 'set columns='  . &columns,
      \ 'set lines='    . &lines,
      \ 'winpos '       . getwinposx() . ' ' . getwinposy(),
      \ ]
    call writefile(options, g:save_window_file)
  endfunction
augroup END
if filereadable(g:save_window_file)
  execute 'source' g:save_window_file
endif
