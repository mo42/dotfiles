#!/bin/zsh

export LC_ALL=en_US.UTF8
export EDITOR=nvim
export TERM=xterm-256color
eval $(dircolors -b $HOME/.dircolors)

if [ -d "$HOME/bin" ]; then
  export PATH=$HOME/bin:$PATH
fi
if [ -d "$HOME/.local/bin" ]; then
  export PATH=$HOME/.local/bin:$PATH
fi
if [ -d "$HOME/.cargo/bin" ]; then
  export PATH=$HOME/.cargo/bin:$PATH
fi
# Space before | and & after completion
export ZLE_SPACE_SUFFIX_CHARS=$'|&'

HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
REPORTTIME=60
LISTMAX=0

# Vim-like behaviour
bindkey -v
bindkey -M vicmd 'k' history-beginning-search-backward
bindkey -M vicmd 'j' history-beginning-search-forward
bindkey -M viins 'jk' vi-cmd-mode
# Perform history expansion (prefix "!", "^")
bindkey -M viins ' ' magic-space
# Clear the prompt and restore after running another command.
bindkey -M vicmd "q" push-line
# Incremental search
bindkey -M vicmd "/" history-incremental-search-forward
bindkey -M vicmd "?" history-incremental-search-backward

# Ignore lines starting with space
setopt hist_ignore_space
# Ignore duplicate history entries
setopt hist_ignore_all_dups
setopt hist_ignore_dups
# Update history immediately
setopt inc_append_history
# Reload the history upon use
setopt share_history
# Better safe than sorry
setopt rm_star_wait 
# Confirm deletions
setopt rm_star_silent
# No annoyances
unsetopt beep
# Show type of files
setopt list_types
# Sort matching filenames numerically
setopt numeric_glob_sort
# Show the exit value with non-zero status
setopt print_exit_value
# Insert prefixes without showing a completion list
setopt auto_list
setopt list_ambiguous
# Make completion list smaller
setopt list_packed
# Resolve symbolic links
setopt chase_links
# Do not push duplicates
setopt pushd_ignore_dups
# Save timestamps in the history file
setopt extended_history
# Require exit or logout
setopt ignore_eof
# Spell check commands
setopt correct
# Remove space if not useful
setopt auto_param_keys
# Add tailing slash
setopt auto_param_slash
# Avoid false reports of spelling errors
setopt hash_list_all

# Frequently used files
alias vrc='$EDITOR ~/.vimrc'
alias zrc='$EDITOR ~/.zshrc'
alias mrc='$EDITOR ~/.mutt/muttrc'
alias zettel='cd ~/zettelkasten && $EDITOR index.md'

alias ls='ls --color=always'
alias ll='ls -lh --color=always --time-style=long-iso'
alias grep='grep -i --color=auto'
alias -g G='| grep -i --color=auto'
alias du='du -h'
alias df='df -h'
# Manage dotfiles using git
alias dotgit='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
# Ask before overwriting
alias mv='mv -i'
alias mvo='rsync --remove-source-files --chown=mo:users'
alias cp='cp -i'

# Modify file names in vim
alias vimv='qmv -f do'
alias zsrc='source ~/.zshrc'

export OS_RELEASE_ID=`cat /etc/os-release | sed -n '/^ID=/p' | sed 's/^...//'`
if [[ "$UID" == "0" ]]; then
  # Root's aliases
  if [[ "$OS_RELEASE_ID" == "arch" ]]; then
    alias sysupdate='pacman --color always -Syu && pacman -Scc'
    alias pacdeb='pacman --color always -R $(pacman -Qtdq)'
    alias pacman='pacman --color always'
  fi
  if [[ "$OS_RELEASE_ID" == "fedora" ]]; then
    alias sysupdate='dnf upgrade'
  fi
else
  # User's aliases
  if [[ "$OS_RELEASE_ID" == "arch" ]]; then
    alias susp='i3lock -c 000000 & systemctl suspend'
  fi
  if [[ "$OS_RELEASE_ID" == "ubuntu" ]]; then
    alias python='python3'
    alias pip='pip3'
  fi
  if [[ "$OS_RELEASE_ID" == "fedora" ]]; then
    umask 077
    alias susp='i3lock -c 000000 & sudo systemctl suspend'
    alias python='python3'
    alias pip='pip3'
  fi
fi

autoload -U colors && colors
autoload -U compinit
compinit
watch=all
logcheck=60
zstyle ':completion:*' list-prompt ''
zstyle ':completion:*' select-prompt ''
# Ignore certain file extensions from vim
zstyle ':completion:*:*:(|g)vi(|m):*' ignored-patterns '*.(pdf|ps)'
# Fix completion for the pdf function below
zstyle ':completion:*:*:pdf:*' file-patterns '*(-/):directories *.(pdf|ps)'
# Completion for TeX files
zstyle ':completion:*:*:(pdf|lua)latex:*' file-patterns '*(-/):directories *.tex'
# Enable colors for completion
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# Create archive files
function carchive() {
  local archive_name="$1.tar.gz"
  archive_name=${archive_name/\//}
  tar cvfz "$archive_name" "$1"
}

# Uncompress various archive files
extr() {
  if [ -f $1 ]; then 
    case $1 in
      (*.tar.gz | *.tgz)    tar -xvzf $1;;
      (*.tar.bz2 | *.tbz2)  tar -xvjf $1;;
      (*.gz)                gunzip -v $1;;
      (*.bz2)               bunzip2 -v $1;;
      (*.zip)               unzip $1;;
      (*.rar)               unrar e $1;;
      (*.tar)               tar -xvf $1;;
      (*.tar.xz)            tar -xJf $1;;
      (*.7z)                7z e $1;;
    esac
  else
    printf 'Error: can not handle file '$1'.'
  fi
}

# Open PDF files
pdf() {
  if [[ -x `which zathura` ]]; then
    zathura --fork $1
  elif [[ -x `which evince` ]]; then
    evince $1 &
  else
    printf "Error: no decent pdf reader available!"
  fi
}

jsonparse() {
  cat $1 | python -c "import sys,json;json.loads(sys.stdin.read())"
}

pdfsplit() {
  gs -dBATCH -dNOPAUSE -sDEVICE=pdfwrite -dFirstPage=$2 -dLastPage=$3 \
    -sOutputFile="${1%%.*}_$2_$3".pdf $1
}

texclean() {
  rm -f *.aux
  rm -f *.bbl
  rm -f *.blg
  rm -f *.fls
  rm -f *.lof
  rm -f *.log
  rm -f *.lot
  rm -f *.out
  rm -f *.toc
  rm -r *.acn
  rm -r *.acr
  rm -r *.alg
  rm -r *.bcf
  rm -r *.fdb_latexmk
  rm -r *.fls
  rm -r *.glg
  rm -r *.glo
  rm -r *.gls
  rm -r *.glsdefs
  rm -r *.run.xml
  rm -r *.lbl
}

# Colored prompt
if [[ "$UID" == "0" ]]; then
  PROMPT="%{$fg_bold[red]%}%n%{$fg_bold[red]%}@%{$fg_bold[blue]%}%m %{$fg_bold[yellow]%}%1~ %{$fg_bold[green]%}%#%{$reset_color%} "
else
  PROMPT="%{$fg_bold[green]%}%n%{$fg_bold[red]%}@%{$fg_bold[blue]%}%m %{$fg_bold[yellow]%}%1~ %{$fg_bold[green]%}%#%{$reset_color%} "
fi

# https://github.com/rupa/z
source ~/code/z/z.sh
