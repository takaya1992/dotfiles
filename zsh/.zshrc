# reattach-to-user-namespace
PATH=$HOME/bin:$PATH

. $HOME/dotfiles/zsh/zplug.zsh

[ -f ~/dotfiles/zsh/aliases.zsh ] && . $HOME/dotfiles/zsh/aliases.zsh
[ -f ~/dotfiles/zsh/custom.zsh ] && . $HOME/dotfiles/zsh/custom.zsh

case "${OSTYPE}" in
# macOS
darwin*)
    [ -f ~/dotfiles/zsh/osx.zsh ] && . ~/dotfiles/zsh/osx.zsh
    ;;
# Linux
linux*)
    [ -f ~/dotfiles/zsh/linux.zsh ] && . ~/dotfiles/zsh/linux.zsh
    ;;
esac
