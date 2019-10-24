# export envs
export LANG="ja_JP.UTF-8"
export EDITOR="vim"
export PAGER="less"
export LESS="-iMS -R"
export GOPATH="$HOME/go"
export PYTHONSTARTUP="$HOME/.pythonrc.py"
export PATH="$PATH:$HOME/bin"

# export user agent strings
export CHROME="Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36"
export FIREFOX="Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:65.0) Gecko/20100101 Firefox/65.0"
export EDGE="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/52.0.2743.116 Safari/537.36 Edge/15.15063"
export IE="Mozilla/5.0 (Windows NT 10.0; WOW64; Trident/7.0; rv:11.0) like Gecko"

# to use ^A, ^E
bindkey -e

# enable completions
autoload -U compinit; compinit -C
export LSCOLORS=gxfxcxdxbxegedabagacad
export LS_COLORS="di=36:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30"
zstyle ":completion:*" list-colors "di=36" "ln=35" "so=32" "ex=31" "bd=46;34" "cd=43;34"
if [ -x "`which completions-yarn 2>/dev/null`" ]; then
  # tabtab source for yarn package
  # uninstall by removing these lines or running `tabtab uninstall yarn`
  [[ -f /Users/yagihash/.anyenv/envs/ndenv/versions/v11.7.0/lib/node_modules/yarn-completions/node_modules/tabtab/.completions/yarn.zsh ]] && . /Users/yagihash/.anyenv/envs/ndenv/versions/v11.7.0/lib/node_modules/yarn-completions/node_modules/tabtab/.completions/yarn.zsh
fi

# word delimiter settings
autoload -U select-word-style; select-word-style default
zstyle ":zle:*" word-chars " /=;@:{},|"
zstyle ":zle:*" word-style unspecified

# set options
setopt prompt_subst         # enable to use ${ENV} in .zshrc
setopt hist_reduce_blanks   # remove unnecessary spaces from history
setopt hist_ignore_all_dups # ignore duplication command history list
setopt share_history        # share command history data between terminals
setopt auto_cd              # change directory without "cd"
setopt autopushd            # pushd automatically
setopt pushd_ignore_dups    # ignore duplicate directory
setopt correct              # correct illegal command name
setopt list_packed          # packing possible completions
setopt complete_aliases     # show aliases for completions
setopt no_beep              # never beep
setopt nolistbeep           # shut up babe

# for displaying git info on prompt
autoload -Uz vcs_info
zstyle ':vcs_info:*' formats "[%F{green}%c%u%b%f / %r]"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}"
zstyle ':vcs_info:git:*' untrackedstr "%F{red}"

autoload colors
colors
RPROMPT="%F{green}%D{%m/%d} %*%f"
SPROMPT="%r ? [n,y,a,e]: "
case ${UID} in
  0)
  PROMPT="%{${fg[magenta]}%}%n%{${reset_color}%}:%1-%(!.#.$) "
  [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
  PROMPT="%{${fg[red]}%}%n%{${reset_color}%}:%1-%(!.#.$) "
  ;;
  *)
  PROMPT="%{${fg[yellow]}%}%n%{${reset_color}%}:%1-%(!.#.$) "
  [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
  PROMPT="%{${fg[blue]}%}%n%{${reset_color}%}:%1-%(!.#.$) "
  ;;
esac

# history management settings
export HISTFILE=~/.zsh_history
export HISTSIZE=1000
export SAVEHIST=100000
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end
bindkey "^R" history-incremental-search-backward

# setting suffix aliases
alias -s go="go run"
alias -s py=python
alias -s rb=ruby
alias -s php=php
alias -s pl=perl
alias -s js=node
alias -s txt=vim

# setting normal aliases
alias ...="cd ../../"
alias ....="cd ../../../"
alias df="df -h"
alias grep="grep --color"
alias watch="watch -d=cumulative"
alias traceroute="sudo traceroute -I -n -w 1"
alias vi="vim"
alias mysql="mysql --pager=less"
alias gip="curl ipinfo.io"
alias wd="git diff --word-diff-regex=$'[^\x80-\xbf][\x80-\xbf]*' --word-diff=color"
alias rm="rm -i"
alias mv="mv -i"
alias curl="curl -s"
case ${OSTYPE} in
  darwin*)
  alias ls="ls -FG -h"
  ;;
  linux*)
  alias ls="ls -F -h --color=auto"
  ;;
esac

# bind function to brank return
function my_enter {
  if [[ -n "$BUFFER" ]]; then
  builtin zle .accept-line
	  return 0
  fi
  if [ "$WIDGET" != "$LASTWIDGET" ]; then
	  MY_ENTER_COUNT=0
  fi
  case $[MY_ENTER_COUNT++] in
	  0)
	  BUFFER="ls"
	  ;;
	  1)
  BUFFER="ls -al"
	  ;;
	  *)
	  unset MY_ENTER_COUNT
	  ;;
  esac
  builtin zle .accept-line
}
zle -N my_enter
bindkey '^m' my_enter

# command line edit on vim
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line

# smart last word insertion
autoload -Uz smart-insert-last-word
zle -N insert-last-word smart-insert-last-word
bindkey '^w' insert-last-word

# omit current directory from directory completion
zstyle ':completion:*' ignore-parents parent pwd ..

# set deletion on the left
bindkey '^U' backward-kill-line

# load local settings
source ~/.zshrc.mine

# configucation for developing environment
export PATH=$PATH:$HOME/.composer/vendor/bin
export PATH=$PATH:./node_modules/.bin

DIRSTACKSIZE=100
setopt auto_pushd

if [ -x "`which peco 2>/dev/null`" ]; then
  function peco-history-selection() {
    BUFFER="$(history -nr 1 | awk '!a[$0]++' | peco --query "$LBUFFER" | sed 's/\\n/\n/')"
    CURSOR=$#BUFFER
    zle reset-prompt
  }
  zle -N peco-history-selection
  bindkey '^R' peco-history-selection

  function peco-pushd-selection() {
    local pushd_number=$(dirs -v | peco | perl -anE 'say $F[0]')
    [[ -z $pushd_number ]] && return 1
    pushd +$pushd_number > /dev/null
    return $?
  }
  zle -N peco-pushd-selection
  bindkey '^h' peco-pushd-selection

  function peco-cd() {
    maxdepth=$1
    list=$(find . -maxdepth ${maxdepth:-1} -mindepth 1 -type d)
    if [ -z ${list} ]; then
      echo 'No directory' >&2
      return 1
    fi

    dst=$(echo ${list} | perl -pe 's/^\.\///g' | sort | peco)
    if [ ${dst} ]; then
      cd $dst
    fi
  }
  alias d='peco-cd'

  alias gs='git switch $(git --no-pager branch | peco)'

  if [ -x "`which ghq 2>/dev/null`" ]; then
    function g() {
      dst=$(ghq list --full-path | cut -d "/" -f 6,7,8 | peco)
      if [ ${dst} ]; then
        cd $(ghq root)/$dst
      fi
    }

    alias gh='hub browse $(ghq list | peco | cut -d "/" -f 2,3)'
  fi
fi

if [ `uname` = "Darwin" ]; then
  if [ -x "`which nyan 2>/dev/null`" ]; then
    alias cat="nyan -t monokai"
  else
    echo -n "install nyan?(y/N): "
    if read -q; then
      echo
      brew install nyan && alias cat="nyan -t monokai"
    else
      echo
      echo skip
    fi
  fi
fi

if [ -x "`which starship 2>/dev/null`" ]; then
  eval "$(starship init zsh)"
elif [ `uname` = "Darwin" ]; then
  echo -n "install starship?(y/N): "
  if read -q; then
    echo
    brew install starship && eval "$(starship init zsh)"
  else
    echo
    echo skip
  fi
elif [ `uname` = "Linux" ]; then
  curl -L 'https://github.com/starship/starship/releases/download/v0.16.0/starship-v0.16.0-x86_64-unknown-linux-gnu.tar.gz' -o /tmp/starship.tar.gz
  tar zfx /tmp/starship.tar.gz x86_64-unknown-linux-gnu/starship
  mkdir -p $HOME/bin
  mv x86_64-unknown-linux-gnu/starship $HOME/bin/starship
  eval "$(starship init zsh)"
  rm -rf /tmp/starship.tar.gz x86_64-unknown-linux-gnu
fi
