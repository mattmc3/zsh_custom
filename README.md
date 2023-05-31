# zsh_custom

My Zsh custom plugins, ideal for [Oh-My-Zsh][omz].

## Install

Fish:

```fish
# vars
set -gx ZDOTDIR ~/.config/zsh
set -gx ZSH_CUSTOM $ZDOTDIR/custom

# clone
test -d $ZSH_CUSTOM || git clone git@github.com:mattmc3/zsh_custom $ZSH_CUSTOM

# symlinks
for zfile in $ZSH_CUSTOM/rcs/*.zsh
  ln -sf $zfile "$ZDOTDIR/."(path change-extension '' (path basename $zfile))
end
echo "source ~/.config/zsh/custom/rcs/zshenv.zsh" > ~/.zshenv
```

Zsh:

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
