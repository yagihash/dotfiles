if [ -d ~/dotfiles ]; then
  echo 'Skip cloning repository'
else
  git clone https://github.com/yagihashoo/dotfiles.git ~/dotfiles
fi

if [ $? = 0 ]; then
  for f in `find ~/dotfiles -type f -maxdepth 1 -name ".*"`
  do
    ln -sfvn $f ~/`basename $f`
  done

  ln -sfvn ~/dotfiles/.vim ~/.vim
  ln -sfvn ~/dotfiles/.peco ~/.peco

  mkdir -p ~/.config
  for f in `find ~/dotfiles/.config -maxdepth 1 -name "*"`
  do
    ln -sfvn $f ~/.config/`basename $f`
  done
else
  echo リポジトリのクローンに失敗しました。
fi
