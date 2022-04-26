# Installation

```
$ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/takaya1992/dotfiles/master/install.sh)"
```

## use zsh

### for macOS

```
$ sudo vi /etc/shells
# append '/usr/local/bin/zsh'
/usr/local/bin/zsh

$ chsh -s /usr/local/bin/zsh
```

## use ricty

### for macOS

```
$ cp -f `brew --prefix ricty`/share/fonts/Ricty*.ttf ~/Library/Fonts/
$ fc-cache -vf
```


## use git

```
$ vim  ~/.gitconfig.local
[user]
  name = [your name]
  email = [your email]
```
