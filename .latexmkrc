#!usr/bin/perl

$latex='uplatex -kanji=utf8 -synctex=1 -halt-on-error -file-line-error %O %S'; #uplatexを使用
#$latex='platex -kanji=utf8 -synctex=1 -halt-on-error %O %S'; #platexを使用
$bibtex='upbibtex -kanji=utf8 %O %B'; #upbibtexを使用
#$bibtex='pbibtex -kanji=utf8 %O %B'; #pbibtexを使用
$dvipdf='dvipdfmx %O -o %D %S'; #dvipdfmxを使用
$makeindex='mendex %O -o %D %S'; #索引を作成するコマンドをmendexと指定。うまく動かない時はコメントアウトすること
$pdf_mode=3; #.tex -> .dvi -> .pdf
$max_repeat=5; #最大コンパイル数
$pdf_update_method=2; #謎

if($^O eq "darwin"){
    $pdf_previewer="open -a preview %S";
}elsif($^O eq "linux"){
    $pdf_previewer="evince";
}

$pvc_view_file_via_temporary=0; #再タイプセット時、古いPDFを削除せず上書きする
$out_dir='output';

#(備考)latexmk上で展開できる主な変数・・・%O:実行時オプション %S: 入力ファイル名 %D: 出力ファイル名 %B: 処理するファイル名の拡張子を除いた文字列
