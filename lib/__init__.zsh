#
# __init__: zsh_custom helper functions and pre-reqs.
#

# Don't double load.
! zstyle -t ':zsh_custom:lib' loaded || return 1

# Initialize profiling.
[[ "$ZPROFRC" -ne 1 ]] || zmodload zsh/zprof
alias zprofrc="ZPROFRC=1 zsh"

# Set essential options
setopt extended_glob interactive_comments

# Make sure ZSH_CUSTOM is properly set.
0=${(%):-%N}
ZSH_CUSTOM=${0:a:h:h}

# Set core Zsh directories.
: ${__zsh_config_dir:=${ZDOTDIR:-${XDG_CONFIG_HOME:-$HOME/.config}/zsh}}
: ${__zsh_cache_dir:=${XDG_CACHE_HOME:-$HOME/.cache}/zsh}
: ${__zsh_user_data_dir:=${XDG_DATA_HOME:-$HOME/.local/share}/zsh}

# Autoload zsh_custom functions
fpath=($ZSH_CUSTOM/functions $fpath)
autoload -Uz autoload-dir && autoload-dir $ZSH_CUSTOM/functions

# Ensure key directory variables exist.
mkdirvar XDG_{CONFIG,CACHE,DATA,STATE}_HOME __zsh_{config,user_data,cache}_dir

##? Echo to stderror
function echoerr {
  echo >&2 "$@"
}

##? Pass thru for copy/paste markdown
function $ { $@ }

##? Check if a file can be autoloaded by trying to load it in a subshell.
function is-autoloadable {
  ( unfunction $1 ; autoload -U +X $1 ) &> /dev/null
}

##? Check if a name is a command, function, or alias.
function is-callable {
  (( $+commands[$1] || $+functions[$1] || $+aliases[$1] || $+builtins[$1] ))
}

##? Check a string for case-insensitive "true" value (1,y,yes,t,true,o,on).
function is-true {
  [[ -n "$1" && "$1:l" == (1|y(es|)|t(rue|)|o(n|)) ]]
}

# OS checks.
function is-macos  { [[ "$OSTYPE" == darwin* ]] }
function is-linux  { [[ "$OSTYPE" == linux*  ]] }
function is-bsd    { [[ "$OSTYPE" == *bsd*   ]] }
function is-cygwin { [[ "$OSTYPE" == cygwin* ]] }
function is-termux { [[ "$OSTYPE" == linux-android ]] }

# Clone plugin repos.
export REPO_HOME=$(repo home)
if [[ ! -e $REPO_HOME/.lastupdated ]] || [[ $ZSH_CUSTOM/repos.txt -nt $REPO_HOME/.lastupdated ]]; then
  repo in < $ZSH_CUSTOM/repos.txt
  date +%Y-%m-%dT%H:%M:%S%z >| $REPO_HOME/.lastupdated
fi

# Add path repos
for repo in romkatv/zsh-bench; do
  [[ -d $REPO_HOME/$repo ]] && path+=($REPO_HOME/$repo)
done

function skipped_plugins {
  local -a skipped allplugins=($ZSH_CUSTOM/plugins/*(:t))
  local plugin
  for plugin in $allplugins; do
    zstyle -t ":zsh_custom:plugin:$plugin" loaded || skipped+=($plugin)
  done
  printf '%s\n' $skipped
}

# Init zstyles.
[[ -r ${ZDOTDIR:-$HOME}/.zstyles ]] && source ${ZDOTDIR:-$HOME}/.zstyles

# Init aliases.
[[ -r ${ZDOTDIR:-$HOME}/.zaliases ]] && source ${ZDOTDIR:-$HOME}/.zaliases

# Init local settings.
[[ -r ${ZDOTDIR:-$HOME}/.zshrc.local ]] && source ${ZDOTDIR:-$HOME}/.zshrc.local

# Run this at the very end.
function zshrc-post {
  # Init prompt.
  if (( $#prompt_themes == 0 )); then
    promptinit

    # Set prompt
    if [[ $TERM == dumb ]]; then
      prompt 'off'
    else
      local -a prompt_argv
      zstyle -a ':zsh_custom:lib:prompt' 'theme' 'prompt_argv' \
        || prompt_argv=(off)
      prompt "$prompt_argv[@]"
    fi
  fi

  # Init completions.
  (( $+functions[compinit] )) || docompinit

  # Finish profiling by calling zprof.
  [[ "$ZPROFRC" -eq 1 ]] && zprof
  [[ -v ZPROFRC ]] && unset ZPROFRC

  # Mark loaded.
  add-zsh-hook -d precmd zshrc-post
}

# Add hook so that zshrc-post is run in case the user forgot to.
autoload -Uz add-zsh-hook
add-zsh-hook precmd zshrc-post  # precmd is the only hook I know to use for this.
