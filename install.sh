git clone https://github.com/yagihashoo/dotfiles.git ~/dotfiles

if [ $? = 0 ]; then
  for f in `find ~/dotfiles -maxdepth 1 -name ".*" | grep -v '.git$' | grep -v '.gitignore$'`
  do
    ln -sfvn $f ~/`basename $f`
  done
else
  echo リポジトリのクローンに失敗しました。
fi
