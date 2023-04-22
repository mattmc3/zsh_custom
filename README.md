# zsh_custom

My Zsh custom plugins, ideal for [Oh-My-Zsh][omz].

## Install

```zsh
setopt extended_glob interactive_comments

# backup existing
export ZDOTDIR=~/.config/zsh
[[ -d $ZDOTDIR ]] && mv $ZDOTDIR ${ZDOTDIR}.bak

# clone and symlink
ZSH_CUSTOM=$ZDOTDIR/custom
[[ -d $ZSH_CUSTOM ]] ||
  git clone git@github.com:mattmc3/zsh_custom $ZSH_CUSTOM

cd $ZDOTDIR
for zfile in ./custom/rcs/*.zsh~*zabbr*; do
  ln -sf $zfile .${zfile:t:r}
done
ln -sf $ZDOTDIR/.zshenv ~/.zshenv
```

[omz]: https://github.com/ohmyzsh/ohmyzsh
