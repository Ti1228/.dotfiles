let g:quickrun_config.spice={
\   'outputter':'error',
\   'outputter/error/success':'null',
\   'outputter/error/error':'quickfix',
\   'srcfile':'%s',
\   'hook/cd/directory':'%S:p:h',
\   'exec':[
\       'mkdir -p output',
\       'hspice64 -i %s:t -o output',
\   ]
\}

nnoremap <leader>r :QuickRun -type spice<CR>

