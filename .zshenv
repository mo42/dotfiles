#!/bin/zsh

export XDG_CONFIG_HOME="$HOME/.config"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
# Zsh history configuration
export HISTFILE="$ZDOTDIR/zsh_history"
export HISTSIZE=100000
export SAVEHIST=100000
setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export EDITOR=nvim

if [ -d "$HOME/bin" ]; then
  export PATH=$HOME/bin:$PATH
fi

if [ -d "$HOME/.local/bin" ]; then
  export PATH=$HOME/.local/bin:$PATH
fi

if [ -d "$HOME/.cargo/bin" ]; then
  export PATH=$HOME/.cargo/bin:$PATH
fi
