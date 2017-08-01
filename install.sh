git clone https://github.com/yagihashoo/dotfiles.git ~/dotfiles

if [ $? = 0 ]; then
  git clone https://github.com/Shougo/neobundle.vim ~/dotfiles/.vim/bundle/neobundle.vim
  for f in `find ~/dotfiles -maxdepth 1 -name ".*" | grep -v git`
  do
    ln -sfvn $f `basename ~/$f`
  done
else
  echo リポジトリのクローンに失敗しました。
fi