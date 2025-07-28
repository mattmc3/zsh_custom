# https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/fancy-ctrl-z/fancy-ctrl-z.plugin.zsh
# https://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
function symmetric-ctrl-z {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line -w
  else
    zle push-input -w
    zle clear-screen -w
  fi
}
zle -N symmetric-ctrl-z

# ctrl-z sends things to the background - make it also bring to forground
bindkey -M emacs '^Z' symmetric-ctrl-z
bindkey -M viins '^Z' symmetric-ctrl-z
