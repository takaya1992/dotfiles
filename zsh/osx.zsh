vimpath=`brew --prefix macvim-kaoriya`/MacVim.App/Contents/MacOS/Vim
export EDITOR=$vimpath
alias vi='env LANG=ja_JP.UTF-8 $vimpath "$@"'
alias vim='env LANG=ja_JP.UTF-8 $vimpath "$@"'

alias ls="ls -alG"

expand-to-home-or-insert () {
        if [ "$LBUFFER" = "" -o "$LBUFFER[-1]" = " " ]; then
                LBUFFER+="~/"
        else
                zle self-insert
        fi
}
zle -N expand-to-home-or-insert
bindkey "@" expand-to-home-or-insert
