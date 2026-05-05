#
# prompt: Setup Zsh prompt
#
0=${(%):-%N}
[[ "$TERM" == dumb ]] && return

# Load our functions
fpath=(${0:a:h}/functions $fpath)
autoload -Uz ${0:a:h}/functions/*(.:t)

# Powerlevel10k doesn't play nice with the built-in Zsh prompt system. You can't
# use instaprompt and change prompts, so if using p10k, we might as well not even
# run promptinit.

_zsh_theme=(${(z)ZSH_THEME})
case ${_zsh_theme[1]} in
  p10k|powerlevel10k)
    prompt_p10k_setup "${_zsh_theme[@][2,-1]}"
    ;;
  *)
    antibody bundle romkatv/powerlevel10k kind:clone
    antibody bundle sindresorhus/pure kind:fpath

    autoload -Uz promptinit && promptinit
    if (( $#_zsh_theme )); then
      prompt ${_zsh_theme[@]}
    fi
    ;;
esac
unset _zsh_theme
