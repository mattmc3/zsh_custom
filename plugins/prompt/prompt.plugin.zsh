fpath=(
  $fpath
  $ZSH_CUSTOM/.external/sindresorhus/pure
  $ZSH_CUSTOM/.external/romkatv/powerlevel10k
)
ZSH_THEME=${ZSH_THEME:-p10k}

setopt PROMPT_SUBST
autoload -Uz promptinit && promptinit

if [[ $ZSH_THEME == pure ]]; then
  # expand parameters in prompt variables
  prompt pure

  #PURE_PROMPT_SYMBOL="%%"

  # show exit code on right
  function precmd_pipestatus {
    local exitcodes="${(j.|.)pipestatus}"
    if [[ "$exitcodes" != "0" ]]; then
      RPROMPT="%F{$prompt_pure_colors[prompt:error]}[$exitcodes]%f"
    else
      RPROMPT=
    fi
  }
  add-zsh-hook precmd precmd_pipestatus

elif [[ $ZSH_THEME == p10k ]]; then
  prompt powerlevel10k
  source ${0:A:h}/p10k.zsh

else
  prompt "$ZSH_THEME"
fi

# https://unix.stackexchange.com/questions/685666/zsh-how-do-i-remove-block-prefixes-when-writing-multi-line-statements-in-intera
# use 2 space indent for each new level
PS2='${${${(%):-%_}//[^ ]}// /  }    '
