"encoding
set encoding=utf-8 "vimの内部文字コード
scriptencoding=utf-8 "文字化け防止
set fileencoding=utf-8 "保存時の文字コード

"global var
if has('win32')||('win64')
    let g:ostype='Win'
elseif has('mac')
    let g:ostype='Mac'
else
    let g:ostype=system('uname') "linux:Linux
endif

if g:ostype=='Win'
    set shellslash "ファイルパスをスラッシュに
    let g:vim_dir=expand('~/vimfiles')
else
    let g:vim_dir=expand('~/.vim')
endif

let g:dein_dir=g:vim_dir.'/bundle'

"required by neosnippet, vimtex
let g:tex_flavor='latex' "texファイルのfiletypeがplaintexになるのを防ぐ

"autocmd initialize
augroup MyAutoCmd
    autocmd!
augroup END

"source
execute 'source' g:vim_dir.'/vimconfig/mkdir.config'
execute 'source' g:vim_dir.'/vimconfig/general.config'
execute 'source' g:vim_dir.'/vimconfig/keymap.config'
execute 'source' g:vim_dir.'/vimconfig/display.config'
execute 'source' g:vim_dir.'/vimconfig/development.config'
execute 'source' g:vim_dir.'/deinconfig/dein.config'

filetype plugin on "deinの起動時に無効化されるため、最後に再び有効化
