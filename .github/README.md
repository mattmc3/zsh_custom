# zsh_custom

My Zsh custom plugins, ideal for [Oh-My-Zsh][omz].

## Install

Backup existing config:

```zsh
setopt extended_glob
export ZDOTDIR=${ZDOTDIR:-~/.zsh}
[[ -d $ZDOTDIR ]] && mv $ZDOTDIR ${ZDOTDIR}.bak
```

Install:

```zsh
setopt extended_glob
for rcfile in $ZDOTDIR/custom/rcs/*.zsh; do
  ln -sf $rcfile $ZDOTDIR/.${rcfile:t:r}
done
ln -sf $ZDOTDIR/custom/rcs/.zshenv ~/.zshenv
```

[omz]: https://github.com/ohmyzsh/ohmyzsh
