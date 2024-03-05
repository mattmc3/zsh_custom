# zsh_custom

My Zsh custom plugins, ideal for [Oh-My-Zsh][omz].

## Install

Backup:

```zsh
cd ~
setopt extended_glob interactive_comments
export ZDOTDIR=${ZDOTDIR:-~/.config/zsh}
[[ -d $ZDOTDIR ]] && mv $ZDOTDIR ${ZDOTDIR}.$(date +"%Y%m%d-%H%M%S").bak
git clone git@github.com:mattmc3/zsh_custom $ZDOTDIR/custom
```

Symlink Zsh runcoms:

```zsh
cd $ZDOTDIR
for f in ./custom/rcs/*.zsh; ln -s $f .${f:t:r}
```

[omz]: https://github.com/ohmyzsh/ohmyzsh
