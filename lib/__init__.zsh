#
# __init__: Init stuff that needs to run first
#

# Initialize
0=${(%):-%N}
MY_ZSH_CUSTOM=${0:a:h:h}

# Run this early so we can P10k instant prompt if we need it.
if [[ "$ZSH_THEME" == p10k* ]] || [[ "$ZSH_THEME" == powerlevel10k* ]]; then
  if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
  fi
fi

autoload -Uz add-zsh-hook

# Zsh has no post_zshrc event, so fake one: a precmd hook that runs once, then
# unregisters itself. Run run_post_zshrc at the end of .zshrc to fire it sooner.
typeset -ga post_zshrc_hook
typeset -gi post_zshrc_done=0

function run_post_zshrc {
  local fn
  for fn in $post_zshrc_hook; do
    "${=fn}"
  done
  post_zshrc_hook=()
  post_zshrc_done=1
  add-zsh-hook -d precmd run_post_zshrc
}

# Adding a hook after the event already fired runs it immediately.
function add-post-zshrc-hook {
  if (( ! post_zshrc_done )); then
    post_zshrc_hook+=("$@")
    return
  fi
  local fn
  for fn in "$@"; do
    "${=fn}"
  done
}

add-zsh-hook precmd run_post_zshrc

# Zsh options OMZ leaves at Zsh defaults. Set after .zshrc so nothing undoes them.
function _zsh_custom_setopts {
  setopt auto_resume             # Attempt to resume existing job before creating a new process.
  setopt combining_chars         # Combine 0-len chars with base chars (eg: accents).
  setopt glob_dots               # Don't hide dotfiles from glob patterns.
  setopt path_dirs               # Perform path search even on command names with slashes.
  setopt pushd_silent            # Do not print the directory stack after pushd or popd.
  setopt pushd_to_home           # Push to home directory when no argument is given.
  setopt rc_quotes               # Allow 'Hitchhiker''s Guide' instead of 'Hitchhiker'\''s Guide'.
  setopt transient_rprompt       # Remove the right prompt from accepted lines.
  setopt NO_beep                 # Don't beep on error in line editor.
  setopt NO_bg_nice              # Don't run all background jobs at a lower priority.
  setopt NO_check_jobs           # Don't report on jobs when shell exit.
  setopt NO_clobber              # Don't overwrite files with >. Use >| to bypass.
  setopt NO_hup                  # Don't kill jobs on shell exit.
  setopt NO_list_beep            # Do not beep on ambiguous completion.
}
add-post-zshrc-hook _zsh_custom_setopts

# termcd: cd to a queued directory written to cache by termcd or any subprocess.
zmodload zsh/datetime
function _termcd_precmd {
  local f="${XDG_CACHE_HOME:-$HOME/.cache}/termcd/${TTY##*/}"
  local dir mtime
  [[ -f "$f" ]] && dir=$(<"$f") || return
  mtime=$(stat -f %m "$f" 2>/dev/null)
  rm -f "$f"
  [[ -n "$mtime" ]] && (( EPOCHSECONDS - mtime > 5 )) && return
  [[ -d "$dir" ]] && cd -- "$dir"
}
add-zsh-hook precmd _termcd_precmd
