# Load all of the modules that were defined in ~/.zshrc
for m ($mymodules); do
  if [ -f $ZSH_CUSTOM/plugins/mymodules/modules/$m.zsh ]; then
    source $ZSH_CUSTOM/plugins/mymodules/modules/$m.zsh
  fi
done
