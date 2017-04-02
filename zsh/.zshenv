export LANG=ja_JP.UTF-8
export LESSCHARSET=utf-8

if type vim > /dev/null 2>&1; then
  EDITOR=vim
else
  EDITOR=vi
fi
export EDITOR

export PAGER=less

if [ -r ~/.zshenv.local ]; then
  . ~/.zshenv.local
fi
