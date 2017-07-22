git clone https://github.com/yagihashoo/dotfiles.git ~/dotfiles

if [ $? = 0 ]; then
  for f in `find ~/dotfiles -name ".*" -maxdepth 1 | grep -v git`
  do
    ln -sfvn $f `basename ~/$f`
  done
  git clone https://github.com/Shougo/neobundle.vim ~/dotfiles/.vim/bundle/neobundle.vim
else
  echo リポジトリのクローンに失敗しました。
fi
