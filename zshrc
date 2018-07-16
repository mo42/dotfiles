#!/bin/zsh

export LC_ALL=en_US.UTF8
export EDITOR=vim
export TERM=xterm-256color
eval $(dircolors -b $HOME/.dircolors)
export OS_RELEASE_ID=`cat /etc/os-release | sed -n '/^ID=/p' | sed 's/^...//'`

if [ -d "$HOME/bin" ]; then
  export PATH=$HOME/bin:$PATH
fi
if [ -d "$HOME/.cabal/bin" ]; then
  export PATH=$HOME/.cabal/bin:$PATH
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
# Clear the prompt. After running a new command it restores the first prompt.
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
alias led='$EDITOR ~/.ledger'

# Task aliases
alias te='task edit'
alias ta='task add'
alias tb='task burndown'
alias tr='task ready'
alias td='task done'
alias ts='task start'
# Collect my ideas and review on Saturday
alias ii='task add due:saturday wait:saturday'

if [[ -x `which task` ]]; then
  alias cal='task calendar'
else
  alias cal='cal -nw'
fi

alias ls='ls --color=always'
alias ll='ls -lh --color=always --time-style=long-iso'
alias grep='grep --color=auto'
alias bal='ledger -f ~/ledger.dat bal'
alias bat='cat /sys/class/power_supply/BAT0/capacity'
alias isync='mbsync -aX'
alias ..='cd ..'
alias ...='cd ..; cd ..'
alias du='du -h'
alias df='df -h'
alias i3lock='i3lock -c 000000'

# Ask before overwriting
alias mv='mv -i'
alias cp='cp -i'
alias cdd='cd ~/downloads'

# Modify file names in vim
alias vimv='qmv -f do'
alias zsrc='source ~/.zshrc'

# Development
alias makeless='make 2>&1 | less -r'
alias cmakedebug='cmake -DCMAKE_BUILD_TYPE=Debug'
alias cmakerelease='cmake -DCMAKE_BUILD_TYPE=Release'
alias gdb='gdb -tui'
alias gd='git diff'
alias gst='git status'
alias gco='git commit'
alias gitg='gitg > /dev/null 2>&1 &'
alias todogrep='grep -Rli "todo\|fixme"'


if [[ "$UID" == "0" ]]; then
  # Root's aliases
  if [[ "$OS_RELEASE_ID" == "arch" ]]; then
    alias sysupdate='pacman --color always -Syu && pacman -Scc'
    alias pacdeb='pacman --color always -R $(pacman -Qtdq)'
    alias pacman='pacman --color always'
  fi
else
  # User's aliases
  if [[ "$OS_RELEASE_ID" == "arch" ]]; then
    alias susp='i3lock -c 000000 & systemctl suspend'
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

mvmp3() {
  mount /dev/sdc1 /mnt/usb
  rm /mnt/usb/*.mp3
  mv /home/mo/downloads/*.mp3 /mnt/usb
  umount /mnt/usb/
}

flac2mp3() {
  for a in ./*.flac; do
    ffmpeg -i "$a" -qscale:a 0 "${a[@]/%flac/mp3}"
  done
}

jsonparse() {
  cat $1 | python -c "import sys,json;json.loads(sys.stdin.read())"
}

pdfsplit() {
  gs -dBATCH -dNOPAUSE -sDEVICE=pdfwrite -dFirstPage=$2 -dLastPage=$3 \
    -sOutputFile="${1%%.*}_$2_$3".pdf $1
}

# Modify dependencies of tasks (first argument depends on seconds argument(s))
taskdepends() {
  task $1 modify depends:$2
}

# Cache output of ls in file (for listing many files)
cls() {
  if [[ ! -a .lscache ]]; then
    ls $1 > .lscache
  fi
  cat .lscache
}

# Colored prompt
if [[ "$UID" == "0" ]]; then
  PROMPT="%{$fg_bold[red]%}%n%{$fg_bold[red]%}@%{$fg_bold[blue]%}%m %{$fg_bold[yellow]%}%1~ %{$fg_bold[green]%}%#%{$reset_color%} "
else
  PROMPT="%{$fg_bold[green]%}%n%{$fg_bold[red]%}@%{$fg_bold[blue]%}%m %{$fg_bold[yellow]%}%1~ %{$fg_bold[green]%}%#%{$reset_color%} "
fi
