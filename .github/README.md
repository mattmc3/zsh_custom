# zsh_custom

My Zsh custom plugins, ideal for [Oh-My-Zsh][omz].

## Install

Backup existing config:

```zsh
setopt extended_glob interactive_comments

# backup existing
export ZDOTDIR=${ZDOTDIR:-~/.zsh}
export ZSH_CUSTOM=$ZDOTDIR/custom
[[ -d $ZDOTDIR ]] && mv $ZDOTDIR ${ZDOTDIR}.bak
```

Install:

```zsh
# setup
setopt extended_glob interactive_comments
export ZSH_CUSTOM=${ZSH_CUSTOM:-${ZDOTDIR:-$HOME/.config/zsh}/custom}

# clone
git clone git@github.com:mattmc3/zsh_custom $ZSH_CUSTOM
cd $ZSH_CUSTOM
for zfile in ./rcs/*.zsh; do
  ln -sf $zfile $ZDOTDIR/.${zfile:t:r}
done
ln -sf ./rcs/.zshenv ~/.zshenv
```

[omz]: https://github.com/ohmyzsh/ohmyzsh
