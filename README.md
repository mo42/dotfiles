# dotfiles

Mange your dotfiles directly with `git`
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
dotgit commit -m "Add vimrc"
```

## Initial Setup
```sh
git init --bare $HOME/.dotfiles
alias dotgit='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
dotgit config status.showUntrackedFiles no
```
