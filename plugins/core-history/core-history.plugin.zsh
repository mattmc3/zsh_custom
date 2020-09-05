# http://zsh.sourceforge.net/Doc/Release/Options.html#History
setopt append_history          # append to history file
setopt extended_history        # write the history file in the ':start:elapsed;command' format
setopt no_hist_beep             # don't beep when attempting to access a missing history entry
setopt hist_expire_dups_first  # expire a duplicate event first when trimming history
setopt hist_find_no_dups       # don't display a previously found event
setopt hist_ignore_all_dups    # delete an old recorded event if a new event is a duplicate
setopt hist_ignore_dups        # don't record an event that was just recorded again
setopt hist_ignore_space       # don't record an event starting with a space
setopt hist_no_store           # don't store history commands
setopt hist_reduce_blanks      # remove superfluous blanks from each command line being added to the history list
setopt hist_save_no_dups       # don't write a duplicate event to the history file
setopt hist_verify             # don't execute immediately upon history expansion
setopt inc_append_history      # write to the history file immediately, not when the shell exits
unsetopt share_history         # don't share history between all sessions

if [[ -z "$SAVEHIST" ]] || [[ $SAVEHIST -le 1000 ]]; then
  SAVEHIST=5000
fi
if [[ -z "$HISTSIZE" ]] || [[ $HISTSIZE -le 2000 ]]; then
  HISTSIZE=10000
fi
if [[ -n "$XDG_DATA_HOME" ]] && [[ -d "$XDG_DATA_HOME" ]]; then
  [[ -d "$XDG_DATA_HOME"/zsh ]] || mkdir -p "$XDG_DATA_HOME"/zsh
  HISTFILE="$XDG_DATA_HOME/zsh/history"
  if [[ ! -f "${ZDOTDIR:-$HOME}/.zsh_history" ]]; then
    ln -sf "$HISTFILE" "${ZDOTDIR:-$HOME}/.zsh_history"
  fi
else
  HISTFILE="${ZDOTDIR:-$HOME}/.zsh_history"
fi
