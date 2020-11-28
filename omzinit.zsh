# oh-my-zsh will run this file, so let's use it to enhance omz

# omz doesn't hangle autoload functions for plugins, so let's add support for
# that if the plugin has a functions subdirectory in $ZSH_CUSTOM
for _p in $plugins; do
  if [ -d $ZSH_CUSTOM/plugins/$_p/functions ]; then
    fpath=($ZSH_CUSTOM/plugins/$_p/functions $fpath)
    for _f in "$ZSH_CUSTOM/plugins/$_p/functions"/*(.N); do
      autoload -Uz "$_f"
    done
  fi
done
unset _p _f
