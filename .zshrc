# export envs
export LANG="ja_JP.UTF-8"
export EDITOR="vim"
export PAGER="less"
export LESS="-iMS"

# to use ^A, ^E
bindkey -e

# enable completions
autoload -U compinit; compinit
export LSCOLORS=exfxcxdxbxegedabagacad
export LS_COLORS="di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30"
zstyle ":completion:*" list-colors "di=34" "ln=35" "so=32" "ex=31" "bd=46;34" "cd=43;34"

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

# set prompts
autoload colors
colors
RPROMPT="`hostname`:%~"
SPROMPT="%r ? [n,y,a,e]: "
case ${UID} in
  0)
  PROMPT="%{${fg[magenta]}%}%n:%1-%(!.#.$)%{${reset_color}%} "
  [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
  PROMPT="%{${fg[red]}%}%n:%1-%(!.#.$)%{${reset_color}%} "
  ;;
  *)
  PROMPT="%{${fg[yellow]}%}%n:%1-%(!.#.$)%{${reset_color}%} "
  [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
  PROMPT="%{${fg[blue]}%}%n:%1-%(!.#.$)%{${reset_color}%} "
  ;;
esac

# history management settings
HISTFILE=~/.zsh_history
HISTSISE=100000
SAVEHIST=100000
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
case ${OSTYPE} in
  darwin*)
  alias ls="ls -FG -h"
  ;;
  linux*)
  alias ls="ls -F -h --color=auto"
  ;;
esac

# setting functions
# function chpwd() { ls }

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

# load local settings
source ~/.zshrc.mine

# set deletion on the left
bindkey '^U' backward-kill-line
