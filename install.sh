#!/bin/bash

#未定義の変数を使おうとした時に打ち止めにする指示
set -u

#このスクリプトファイルの絶対PATHを取得し，移動
THIS_DIR=$(cd $(dirname $0) && pwd)
    #${}は変数、$0はスクリプト名を表す特殊変数
    #dirnameコマンドは、引数に与えられたファイルのディレクトリを返す
    #セミコロン(;)または&&で区切って複数のコマンドを記述することでコマンドを連続実行できる
    #cdでスクリプト設置場所へ移動した後に、pwdでその場所を変数THIS_DIRに代入している
cd $THIS_DIR

echo "start setup..."

#tpmをgit clone
CLONE_TO=~/.tmux/plugins/tpm
REPO_URL=https://github.com/tmux-plugins/tpm
BRANCH=master
if [ -d "$CLONE_TO" ]; then
    cd $CLONE_TO
    git fetch -p
    git checkout -q $BRANCH
    latest_rev=$(git ls-remote origin HEAD|awk '{print $1}')
    current_rev=$(git rev-parse HEAD)
    if [ "$latest_rev" != "$current_rev" ]; then
        git reset --hard $(git log --pretty=format:%H | tail -1)
        git pull
    fi
else
    git clone $REPO_URL $CLONE_TO
fi
cd $THIS_DIR

#先頭がドットで始まり、2文字以上のファイルを探索、シンボリックリンク作成
for dotfile in .??*
do
    #処理中のファイルが例外となる対象であればcontinue
    if [ $dotfile = .git ] ; then continue #[]はtestコマンドの略式
    elif [ $dotfile = .gitignore ] ; then continue
    elif [ $dotfile = .gitconfig.local.template ] ; then continue
    elif [ $dotfile = .require_oh-my-zsh ] ; then continue
    elif [ $dotfile = .gitmodules ] ; then continue
    elif [ $dotfile = .*.swp ] ; then continue
    elif [ $dotfile = .vim ] ; then continue
    fi

    ln -snfv "$THIS_DIR"/"$dotfile" ~/"$dotfile"
done


#インストール先ディレクトリがなければ作成し、ドットファイル以外のファイルもリンク作成
cd .tmux
mkdir -p ~/.tmux
for tmuxconf in *.conf
do
    ln -snfv "$THIS_DIR"/.tmux/"$tmuxconf" ~/.tmux/"$tmuxconf"
done
cd ../


cd .vim/ftplugin
mkdir -p ~/.vim/ftplugin
for ftplugin in *.vim
do
    ln -snfv "$THIS_DIR"/.vim/ftplugin/"$ftplugin" ~/.vim/ftplugin/"$ftplugin"
done
cd ../

cd pluginconfig
mkdir -p ~/.vim/pluginconfig
for pluginconfig in *.config
do
    ln -snfv "$THIS_DIR"/.vim/pluginconfig/"$pluginconfig" ~/.vim/pluginconfig/"$pluginconfig"
done
cd ../

cd deinconfig
mkdir -p ~/.vim/deinconfig
ln -snfv "$THIS_DIR"/.vim/deinconfig/dein.config ~/.vim/deinconfig/dein.config
ln -snfv "$THIS_DIR"/.vim/deinconfig/dein.toml ~/.vim/deinconfig/dein.toml
ln -snfv "$THIS_DIR"/.vim/deinconfig/dein_lazy.toml ~/.vim/deinconfig/dein_lazy.toml
cd ../

cd vimconfig
mkdir -p ~/.vim/vimconfig
for vimconfig in *.config
do
    ln -snfv "$THIS_DIR"/.vim/vimconfig/"$vimconfig" ~/.vim/vimconfig/"$vimconfig"
done
cd ../

cd snippet
mkdir -p ~/.vim/snippet
for snippet in *.snip
do
    ln -snfv "$THIS_DIR"/.vim/snippet/"$snippet" ~/.vim/snippet/"$snippet"
done
cd ../


cd ../

#「END」が現れるまでの範囲の文章をcat
cat << END
************************
DOTFILES SETUP FINISHED.
************************
END

