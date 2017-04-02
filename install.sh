#!/bin/sh

set -e
set -u

dotfiles=$HOME/dotfiles
brewfile="$dotfiles/macOS/Brewfile"

has() {
  type "$1" > /dev/null 2>&1
}

symlink() {
  [ -e "$2" ] || [ -e "$2".norc ] || [ -L "$2" ] || {
    mkdir -p "`dirname $2`"
    ln -s "$1" "$2"
  }
}

is_mac() {
  [ "$(uname)" == 'Darwin' ]
}

is_linux() {
  [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]
}

is_cygwin() {
  [ "$(expr substr $(uname -s) 1 10)" == 'MINGW32_NT' ]
}

if is_mac || is_linux || is_cygwin; then
  :
else
  echo "Your platform ($(uname -a)) is not supported."
  exit 1
fi

if [ -d "$dotfiles" ]; then
  (cd "$dotfiles" && git pull --ff-only)
else
  git clone https://github.com/takaya1992/dotfiles "$dotfiles"
fi

# package install
if is_mac; then
  if has brew; then
    :
  else
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi
  brew tap Homebrew/bundle && brew bundle --file="$brewfile"
fi

# zsh
if has zsh; then
  if [ -e "$HOME/.zplug" ]; then
    :
  else
    curl -sL --proto-redir -all,https https://zplug.sh/installer | zsh
  fi
  symlink "$dotfiles/zsh/.zprofile" "$HOME/.zprofile"
  symlink "$dotfiles/zsh/.zshenv" "$HOME/.zshenv"
  symlink "$dotfiles/zsh/.zshrc" "$HOME/.zshrc"
fi

# tmux
if has tumx; then
  symlink "$dotfiles/tmux/.tmux.conf" "$HOME/.tmux.conf"
fi

# git
if has git; then
  symlink "$dotfiles/git/.gitignore-global" "$HOME/.gitignore-global"
  symlink "$dotfiles/git/.gitconfig" "$HOME/.gitconfig"
fi

# vim
if has vim; then
  symlink "$dotfiles/vim/.vimrc" "$HOME/.vimrc"
fi
