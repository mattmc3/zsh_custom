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
git clone git@github.com:mattmc3/zsh_custom $ZSH_CUSTOM
ln -s $ZSH_CUSTOM/rcs/zshenv.zsh ~/.zshenv
ln -s $ZSH_CUSTOM/rcs/zshrc.zsh $ZDOTDIR/.zshrc
```

[omz]: https://github.com/ohmyzsh/ohmyzsh
