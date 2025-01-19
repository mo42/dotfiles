# dotfiles

![dotfiles example in Sway](example.png)

I manage my dotfiles directly with `git`
([based on this HN post](https://news.ycombinator.com/item?id=11071754)).

## Replicate on new Machine
```sh
git clone --separate-git-dir=$HOME/.dotfiles https://github.com/mo42/dotfiles.git dotfiles-tmp
cp -r dotfiles-tmp/.* ~
rm -r ~/tmp-dotfiles
```

## Example: Add Vim Configuration
```sh
dotgit status
dotgit add .vimrc
dotgit commit -m "Every good setup needs a vimrc"
```

## Initial Setup
```sh
git init --bare $HOME/.dotfiles
alias dotgit='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
# Don't show untracked files
dotgit config status.showUntrackedFiles no
```

## Setup NeoVim
```sh
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
   https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```
