# プロンプトが表示されるたびにプロンプト文字列を評価、置換する
setopt prompt_subst
setopt transient_rprompt

## Default shell configuration
# colors enables us to idenfity color by $fg[red].
autoload colors
colors
case ${UID} in
0)
   PROMPT="%B%{${fg[red]}%}%/#%{${reset_color}%}%b "
   PROMPT2="%B%{${fg[red]}%}%_#%{${reset_color}%}%b "
   SPROMPT="%B%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%}%b "
   [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
       PROMPT="%{${fg[cyan]}%}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') ${PROMPT}"
   ;;
*)
   #
   # Color
   #
   DEFAULT=$'%{\e[1;0m%}'
   RESET="%{${reset_color}%}"
   GREEN="%{${fg[green]}%}"
   BLUE="%{${fg[blue]}%}"
   RED="%{${fg[red]}%}"
   CYAN="%{${fg[cyan]}%}"
   WHITE="%{${fg[white]}%}"
   POH="(๑•̀ㅂ•́)و✧  $"

   #
   # Prompt
   #
   PROMPT='%{$fg_bold[blue]%}${RESET} %* | ${WHITE}${POH} ${RESET}'
   RPROMPT='${RESET}${WHITE}[${BLUE}%(5~,%-2~/.../%2~,%~)% ${WHITE}]${RESET}'

   #
   # Vi入力モードでPROMPTの色を変える
   # http://memo.officebrook.net/20090226.html
   function zle-line-init zle-keymap-select {
     case $KEYMAP in
       vicmd)
       PROMPT="%{$fg_bold[cyan]%}${RESET} %* | ${WHITE}${POH} ${RESET}"
       ;;
       main|viins)
       PROMPT="%{$fg_bold[blue]%}${RESET} %* | ${WHITE}${POH} ${RESET}"
       ;;
     esac
     zle reset-prompt
   }
   zle -N zle-line-init
   zle -N zle-keymap-select

esac

# 指定したコマンド名がなく、ディレクトリ名と一致した場合 cd する
setopt auto_cd

# cd でTabを押すとdir list を表示
setopt auto_pushd

# ディレクトリスタックに同じディレクトリを追加しないようになる
setopt pushd_ignore_dups

# コマンドのスペルチェックをする
setopt correct

# コマンドライン全てのスペルチェックをする
setopt correct_all

# 上書きリダイレクトの禁止
setopt no_clobber

# 補完候補リストを詰めて表示
setopt list_packed
# auto_list の補完候補一覧で、ls -F のようにファイルの種別をマーク表示
setopt list_types

# 補完候補が複数ある時に、一覧表示する
setopt auto_list

# コマンドラインの引数で --prefix=/usr などの = 以降でも補完できる
setopt magic_equal_subst

# カッコの対応などを自動的に補完する
setopt auto_param_keys

# ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt auto_param_slash

# {a-c} を a b c に展開する機能を使えるようにする
setopt brace_ccl

# シンボリックリンクは実体を追うようになる
#setopt chase_links

# 補完キー（Tab,  Ctrl+I) を連打するだけで順に補完候補を自動で補完する
setopt auto_menu

# sudoも補完の対象
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin

# 色付きで補完する
zstyle ':completion:*' list-colors di=34 fi=0
#zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# 複数のリダイレクトやパイプなど、必要に応じて tee や cat の機能が使われる
setopt multios

# 最後がディレクトリ名で終わっている場合末尾の / を自動的に取り除かない
setopt noautoremoveslash

# beepを鳴らさないようにする
setopt nolistbeep

# Match without pattern
# ex. > rm *~398
# remove * without a file "398". For test, use "echo *~398"
setopt extended_glob

# 余分な空白は詰める
setopt hist_reduce_blanks

# add history when command executed.
setopt inc_append_history

# history (fc -l) コマンドをヒストリリストから取り除く。
setopt hist_no_store

# コマンドラインでも # 以降をコメントと見なす
setopt interactive_comments

# コマンド名に / が含まれているとき PATH 中のサブディレクトリを探す
setopt path_dirs

# ctrl-w, ctrl-bキーで単語移動
bindkey "^W" forward-word
bindkey "^B" backward-word

# back-wordでの単語境界の設定
autoload -Uz select-word-style
select-word-style default
zstyle ':zle:*' word-chars " _-./;@"
zstyle ':zle:*' word-style unspecified

# URLをコピペしたときに自動でエスケープ
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

# 勝手にpushd
setopt autopushd

# エラーメッセージ本文出力に色付け
e_normal=`echo -e "¥033[0;30m"`
e_RED=`echo -e "¥033[1;31m"`
e_BLUE=`echo -e "¥033[1;36m"`

function make() {
    LANG=C command make "$@" 2>&1 | sed -e "s@[Ee]rror:.*@$e_RED&$e_normal@g" -e "s@cannot¥sfind.*@$e_RED&$e_normal@g" -e "s@[Ww]arning:.*@$e_BLUE&$e_normal@g"
}
function cwaf() {
    LANG=C command ./waf "$@" 2>&1 | sed -e "s@[Ee]rror:.*@$e_RED&$e_normal@g" -e "s@cannot¥sfind.*@$e_RED&$e_normal@g" -e "s@[Ww]arning:.*@$e_BLUE&$e_normal@g"
}

## Completion configuration
#
fpath=(~/.zsh/functions/Completion ${fpath})
autoload -U compinit
compinit -u


## zsh editor
#
autoload zed


## Prediction configuration
#
autoload predict-on
#predict-off

## Command Line Stack [Esc]-[q]
bindkey -a 'q' push-line

## terminal configuration
# http://journal.mycom.co.jp/column/zsh/009/index.html
unset LSCOLORS

case "${TERM}" in
xterm)
    export TERM=xterm-color

    ;;
kterm)
    export TERM=kterm-color
    # set BackSpace control character

    stty erase
    ;;

cons25)
    unset LANG
  export LSCOLORS=ExFxCxdxBxegedabagacad

    export LS_COLORS='di=01;32:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30'
    zstyle ':completion:*' list-colors \
        'di=;36;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
    ;;

kterm*|xterm*)
    export CLICOLOR=1
    export LSCOLORS=ExFxCxDxBxegedabagacad

    zstyle ':completion:*' list-colors \
        'di=36' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
    ;;

dumb)
    echo "Welcome Emacs Shell"
    ;;
esac

HISTFILE=~/.zsh_history
HISTSIZE=10000000
SAVEHIST=$HISTSIZE
# zsh の開始・終了時刻をヒストリファイルに書き込む
setopt extended_history
# 履歴をインクリメンタルに追加
setopt inc_append_history
# 登録済コマンド行は古い方を削除
setopt hist_ignore_all_dups
# historyの共有
setopt share_history
# historical backward/forward search with linehead string binded to ^P/^N
#
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end
bindkey "\\ep" history-beginning-search-backward-end
bindkey "\\en" history-beginning-search-forward-end

# glob(*)によるインクリメンタルサーチ
bindkey '^R' history-incremental-pattern-search-backward
bindkey '^S' history-incremental-pattern-search-forward

function peco-select-history() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=$(\history -n 1 | \
        eval $tac | \
        peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
