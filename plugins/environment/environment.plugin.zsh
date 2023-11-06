#
# environment - Define Zsh environment variables.
#
# https://github.com/sorin-ionescu/prezto/blob/master/runcoms/zprofile

#
# XDG
#

# Set XDG base dirs.
# https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}

# Zsh dirs
: ${__zsh_config_dir:=${ZDOTDIR:-$XDG_CONFIG_HOME/zsh}}
: ${__zsh_user_data_dir:=$XDG_DATA_HOME/zsh}
: ${__zsh_cache_dir:=$XDG_CACHE_HOME/zsh}

# Ensure Zsh dirs exist.
for _zdir in __zsh_{config,user_data,cache}_dir; do
  [[ -e ${(P)_zdir} ]] || mkdir -p ${(P)_zdir}
done
unset _zdir

#
# Common
#

# Set editor variables.
export EDITOR=vim
export VISUAL=code
export PAGER=less

# Browser.
if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER='open'
fi

# Regional settings
export LANG='en_US.UTF-8'

# Ensure path arrays do not contain duplicates.
typeset -gU fpath path cdpath

# Set the list of directories that cd searches.
cdpath=(
  ~/Projects(N/)
  ~/Projects/*(N/)
  $cdpath
)

# Set the list of directories that Zsh searches for programs.
path=(
  # core
  $HOME/{,s}bin(N)
  /opt/{homebrew,local}/{,s}bin(N)
  /usr/local/{,s}bin(N)

  # emacs
  $HOME/.emacs.d/bin(N)
  $XDG_CONFIG_HOME/emacs/bin(N)

  # path
  $path
)

#
# Less
#

# Set the default Less options.
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# Remove -X to enable it.
if [[ -z "$LESS" ]]; then
  export LESS='-g -i -M -R -S -w -z-4'
fi

# Set the Less input preprocessor.
# Try both `lesspipe` and `lesspipe.sh` as either might exist on a system.
if [[ -z "$LESSOPEN" ]] && (( $#commands[(i)lesspipe(|.sh)] )); then
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi

#
# Misc
#

export DOTFILES=$XDG_CONFIG_HOME/dotfiles
export KEYTIMEOUT=1

# Make Apple Terminal behave.
export SHELL_SESSIONS_DISABLE=1

# Use `< file` to quickly view the contents of any file.
[[ -z "$READNULLCMD" ]] || READNULLCMD=$PAGER
