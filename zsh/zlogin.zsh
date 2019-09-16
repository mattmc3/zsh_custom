(
  local dir file
  setopt LOCAL_OPTIONS EXTENDED_GLOB
  autoload -U zrecompile

  # zcompile the completion cache; siginificant speedup
  # find the $zcompdump_file or anything that begins with .zcompdump that isn't a .zwc
  zrecompile -pq ${ZDOTDIR:-$HOME}/${zcompdump_file:-.zcompdump*~*.zwc}(.N)

  # zcompile .zshrc
  zrecompile -pq ${ZDOTDIR:-$HOME}/.zshrc

  # if we're using oh-my-zsh, compile all that stuff
  if [[ -d $ZSH ]]; then
    # zcompile root OMZ
    zrecompile -pq $ZSH/oh-my-zsh.sh

    # zcompile root omz lib
    for file in {$ZSH,$ZSH_CUSTOM}/lib/*.zsh(.N); do
      zrecompile -pq ${file}
    done

    # zcompile enabled omz-plugins
    if [ -n "$plugins" ]; then
      for file in {$ZSH,$ZSH_CUSTOM}/plugins/${^plugins}/**/*.zsh{,-theme}(.N); do
        zrecompile -pq ${file}
      done
    fi

    # zcompile theme
    if [ -n "$ZSH_THEME" ]; then
      for file in {$ZSH,$ZSH_CUSTOM}/themes/$ZSH_THEME.zsh-theme(.N); do
        zrecompile -pq ${file}
      done
    fi

    # clean our mess
    find $ZSH -type f -name "*.zwc.old" -delete
    find $HOME -type f -name "*.zwc.old" -maxdepth 1 -delete
    find ${ZDOTDIR:-$HOME} -type f -name "*.zwc.old" -maxdepth 1 -delete
  fi
) &!
