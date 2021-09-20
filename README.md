# dotfiles

https://news.ycombinator.com/item?id=11071754

## Replicate on new machine

```console
git clone --separate-git-dir=~/.dotfiles /path/to/repo ~/tmp-dotfiles
rm -r ~/tmp-dotfiles
```

## Example: Add Vim Config
```console
dotgit status
dotgit add .vimrc
dotgit commit -m "Add vimrc"
```

## Initial Setup
```console
git init --bare $HOME/.dotfiles
alias dotgit='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
dotgit config status.showUntrackedFiles no
```
