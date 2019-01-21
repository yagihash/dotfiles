# export envs
export LANG="ja_JP.UTF-8"
export EDITOR="vim"
export PAGER="less"
export LESS="-iMS -R"
export GOPATH="~/go"

# to use ^A, ^E
bindkey -e

# enable completions
autoload -U compinit; compinit -C
export LSCOLORS=gxfxcxdxbxegedabagacad
export LS_COLORS="di=36:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30"
zstyle ":completion:*" list-colors "di=36" "ln=35" "so=32" "ex=31" "bd=46;34" "cd=43;34"

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
print_cwd() {
  print
  local left='(%{\e[38;5;2m%}%~%{\e[m%})'
  vcs_info
  local right="${vcs_info_msg_0_}"
  local invisible='%([BSUbfksu]|([FK]|){*})'
  local leftwidth=${#${(S%%)left//$~invisible/}}
  local rightwidth=${#${(S%%)right//$~invisible/}}
  local padwidth=$(($COLUMNS - ($leftwidth + $rightwidth) % $COLUMNS))
  print -P $left${(r:$padwidth:: :)}$right
}
autoload -Uz add-zsh-hook
add-zsh-hook precmd print_cwd

# set prompts
autoload colors
colors
RPROMPT="%F{green}`LANG=C date "+%m/%d(%a) %H:%m:%S"`%f"
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
  bindkey '^B' peco-pushd-selection

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

  alias gc='git checkout $(git --no-pager branch | peco)'

  if [ -x "`which ghq 2>/dev/null`" ]; then
    function gg() {
      dst=$(ghq list --full-path | grep $GOPATH | cut -d "/" -f 6,7,8 | peco)
      if [ ${dst} ]; then
        cd $GOPATH/src/$dst
      fi
    }
    # alias gg='cd $GOPATH/src/$(ghq list --full-path | grep $GOPATH | cut -d "/" -f 6,7,8 | peco)'

    function g() {
      dst=$(ghq list --full-path | grep -v $GOPATH | cut -d "/" -f 5,6,7 | peco)
      if [ ${dst} ]; then
        cd $(ghq root)/$dst
      fi
    }

    alias gh='hub browse $(ghq list | peco | cut -d "/" -f 2,3)'
  fi
fi

# if [ -x "`which tmux 2>/dev/null`" -a -x "`which peco 2>/dev/null`" ]; then
# 	if [[ ! -n $TMUX && $- == *l* ]]; then
#   	# get the IDs
#   	ID="`tmux list-sessions`"
#   	if [[ -z "$ID" ]]; then
#     	tmux new-session
#   	fi
#   	create_new_session="Create New Session"
#   	ID="$ID\n${create_new_session}:"
#   	ID="`echo $ID | peco | cut -d: -f1`"
#   	if [[ "$ID" = "${create_new_session}" ]]; then
#     	tmux new-session
# 		elif [[ -n "$ID" ]]; then
# 			tmux attach-session -t "$ID"
#   	else
#     	:  # Start terminal normally
#   	fi
# 	fi
# fi

# for zprof
## Add line below to ~/.zshenv
## zmodload zsh/zprof && zprof
# if (which zprof > /dev/null) ;then
#   zprof | less
# fi
