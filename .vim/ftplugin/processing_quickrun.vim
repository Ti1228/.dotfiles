let g:quickrun_config.processing={
\   'outputter':'error',
\   'outputter/error/success':'null',
\   'outputter/error/error':'quickfix',
\   'command':'processing-java',
\   'exec':'%c --sketch=%s:p:h/ --run --force'
\}
"%s=filename :p:h=ファイルの存在するディレクトリの絶対PATH
