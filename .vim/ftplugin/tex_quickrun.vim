"quickfixの自家製エラー検出フォーマット
"未完成
"let &errorformat = '
"    \%m\ at\ lines\ %l%.%#,
"    \%.%# Warning:\ %m,
"    \%A!\ %m,
"    \%Cl.%l\ %m,
"    \%Z\n,
"    \%C%m,
"    \%-G%.%#,
"\'

"全体コンパイル
let g:quickrun_config.tex={
\   'outputter':'error',
\   'outputter/error/success':'null',
\   'outputter/error/error':'quickfix',
\   'command':'latexmk',
\   'srcfile':'%s',
\   'cmdopt':'-pv',
\   'hook/cd/directory':'%S:p:h',
\   'exec':'%c %o %s:t',
\}

"中間ファイル除去
let g:quickrun_config.texfinish={
\   'outputter':'error',
\   'outputter/error/success':'null',
\   'outputter/error/error':'quickfix',
\   'command':'latexmk',
\   'srcfile':'%s',
\   'cmdopt':'-c',
\   'hook/cd/directory':'%S:p:h',
\   'exec':'%c %o',
\}

"部分コンパイル
"latexmk -cが不調のためhook/sweepを使用
let g:quickrun_config.tmptex={
\   'outputter':'error',
\   'outputter/error/success':'null',
\   'outputter/error/error':'quickfix',
\   'cmdopt':'-pv',
\   'args':expand("%:p:h"),
\   'exec':[
\       'mv %s %a/temp.tex',
\       'latexmk %o %a/temp.tex',
\   ],
\
\   'hook/eval/enable':1,
\   'hook/cd/directory':'%a',
\   'hook/eval/template':'\documentclass[uplatex, a4j, 11pt]{jsarticle}'
\                         .'\usepackage[top=30truemm, bottom=30truemm, left=25truemm, right=25truemm]{geometry}'
\                         .'\usepackage[dvipdfmx]{graphicx}'
\                         .'\usepackage[dvipdfmx]{color}'
\                         .'\usepackage{subcaption}'
\                         .'\usepackage{amsmath, amssymb}'
\                         .'\usepackage{cases}'
\                         .'\usepackage[at]{easylist}'
\                         .'\usepackage{siunitx}'
\                         .'\usepackage{bm}'
\                         .'\usepackage{here}'
\                         .'\usepackage[T1]{fontenc}'
\                         .'\usepackage{lmodern}'
\                         .'\usepackage[utf8]{inputenc}'
\                         .'\usepackage{cite}'
\                         .'\graphicspath{{../../figures/}}'
\                         .'\begin{document}'
\                         .'%s'
\                         .'\end{document}',
\   'hook/sweep/files':[
\           '%a/output/temp.aux',
\           '%a/output/temp.fdb_latexmk',
\           '%a/output/temp.fls',
\           '%a/output/temp.log',
\           '%a/output/temp.out',
\           '%a/temp.tex',
\   ],
\}

"全体コンパイル
nnoremap <silent> <leader>r :QuickRun -type tex<CR>

"部分コンパイル
vnoremap <buffer> <leader>r :QuickRun -mode v -type tmptex<CR>

augroup MyAutoCmd
    "セーブ時に自動コンパイル
    "autocmd BufWritePost,FileWritePost *.tex :QuickRun -type tex
    "Vim終了時に中間ファイル除去
    autocmd VimLeave *.tex :QuickRun -type texfinish
augroup END
