# rcs

```zsh
: ${ZSH_CUSTOM:=${ZDOTDIR:-$HOME/.zsh}/custom}
for zrc in $ZSH_CUSTOM/rcs/*.zsh; do
  ln -sf ${zrc} ${ZDOTDIR:-$HOME/.zsh}/.${zrc:t:r}
done
```
