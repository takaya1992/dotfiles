eval "$(/opt/homebrew/bin/brew shellenv)"

type plenv > /dev/null 2>&1 && eval "$(plenv init -)"
type rbenv > /dev/null 2>&1 && eval "$(rbenv init -)"
type goenv > /dev/null 2>&1 && eval "$(goenv init -)"
type nodenv > /dev/null 2>&1 && eval "$(nodenv init -)"

if [ -r ~/.zprofile.local ]; then
  . ~/.zprofile.local
fi
