if [ -d ~/dotfiles ]; then
  echo 'Skip cloning repository'
else
  git clone https://github.com/yagihashoo/dotfiles.git ~/dotfiles
fi

if [ $? = 0 ]; then
  for f in `find ~/dotfiles -maxdepth 1 -name ".*" | grep -v '.git$' | grep -v '.gitignore$' | grep -v '.config$'`
  do
    ln -sfvn $f ~/`basename $f`
  done

  mkdir -p ~/.config
  for f in `find ~/dotfiles/.config -maxdepth 1 -name "*"`
  do
    ln -sfvn $f ~/.config/`basename $f`
  done
else
  echo リポジトリのクローンに失敗しました。
fi
