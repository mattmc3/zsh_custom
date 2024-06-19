#
# environment - Ensure common environment variables are defined.
#

# Reference:
# - https://github.com/sorin-ionescu/prezto/blob/master/runcoms/zprofile

# Bootstrap.
0=${(%):-%N}
: ${ZSH_CUSTOM:=${0:a:h:h:h}}
zstyle -t ':zsh_custom:lib' loaded || source $ZSH_CUSTOM/lib/__init__.zsh

# Editors
export EDITOR=${EDITOR:-nano}
export VISUAL=${VISUAL:-nano}
export PAGER=${PAGER:-less}

# Set browser.
if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER=${BROWSER:-open}
fi

# Set language.
export LANG=${LANG:-en_US.UTF-8}

# Ensure path arrays do not contain duplicates.
typeset -gU cdpath fpath mailpath path

# Set the list of directories that cd searches.
# cdpath=(
#   $cdpath
# )

# Set the list of directories that Zsh searches for programs.
path=(
  $HOME/{,s}bin(N)
  /opt/{homebrew,local}/{,s}bin(N)
  /usr/local/{,s}bin(N)
  $ZSH_CUSTOM/bin(N)
  $path
)

# Set the default Less options.
# Mouse-wheel scrolling can be disabled with -X (disable screen clearing).
# Add -X to disable it.
if [[ -z "$LESS" ]]; then
  export LESS='-g -i -M -R -S -w -z-4'
fi

# Set the Less input preprocessor.
# Try both `lesspipe` and `lesspipe.sh` as either might exist on a system.
if [[ -z "$LESSOPEN" ]] && (( $#commands[(i)lesspipe(|.sh)] )); then
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi

# Reduce key delay
export KEYTIMEOUT=${KEYTIMEOUT:-1}

# Make Apple Terminal behave.
if [[ "$OSTYPE" == darwin* ]]; then
  export SHELL_SESSIONS_DISABLE=${SHELL_SESSIONS_DISABLE:-1}
fi

# Use `< file` to quickly view the contents of any file.
[[ -z "$READNULLCMD" ]] || READNULLCMD=$PAGER
