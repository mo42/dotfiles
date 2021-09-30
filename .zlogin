if [[ `uname` == "Linux" ]]; then
  [[ -z $DISPLAY && "$(fgconsole)" -eq 1 ]] && exec startx
fi
