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
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
  brew tap Homebrew/bundle && brew bundle --file="$brewfile"
fi

# zsh
if has zsh; then
  if [ -e "$HOME/.zplug" ]; then
    :
  else
    curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
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

  GIT_CONFIG_FILE="$HOME/.gitconfig.local"
  
  if [ -e $GIT_CONFIG_FILE ]; then
    :
  else
    touch $GIT_CONFIG_FILE
  fi
  
  HAS_USER_SECTION=0
  HAS_USERNAME=0
  HAS_EMAIL=0
  
  if grep -e "^\[user\]$" $GIT_CONFIG_FILE > /dev/null; then
    HAS_USER_SECTION=1
  fi
  if grep -e "name\s*=\s*\S\+$" $GIT_CONFIG_FILE > /dev/null; then
    HAS_USERNAME=1
  fi
  if grep -e "email\s*=\s*\S\+$" $GIT_CONFIG_FILE > /dev/null; then
    HAS_EMAIL=1
  fi
  
  # すべてなかったら書き込み
  if [ $HAS_USER_SECTION -eq 0 ] && [ $HAS_USERNAME -eq 0 ] && [ $HAS_EMAIL -eq 0 ]; then
    echo "GIT USERNAME: "
    read name
    echo "GIT EMAIL: "
    read email
  
    echo "[user]" >> $GIT_CONFIG_FILE
    echo "    name = $name" >> $GIT_CONFIG_FILE
    echo "    email = $email" >> $GIT_CONFIG_FILE
  else
    if [ $HAS_USER_SECTION -eq 1 ] && [ $HAS_USERNAME -eq 1 ] && [ $HAS_EMAIL -eq 1 ]; then
      # すべてあれば何もしない
      :
    else
      echo "git の user 設定に誤りがあるかもしれないです : $GIT_CONFIG_FILE"
    fi
  fi
fi

# vim
if has vim; then
  symlink "$dotfiles/vim/.vimrc" "$HOME/.vimrc"
fi
