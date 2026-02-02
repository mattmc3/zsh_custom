#
# environment: Ensure common environment variables are set.
#

# Set Zsh options related to globbing.
setopt extended_glob         # Use more awesome globbing features.
setopt NO_rm_star_silent     # Ask for confirmation for `rm *' or `rm path/*'

# Set general Zsh options.
setopt combining_chars       # Combine 0-len chars with the base character (eg: accents).
setopt interactive_comments  # Enable comments in interactive shell.
setopt rc_quotes             # Allow 'Hitchhikers''s Guide' instead of 'Hitchhikers'\''s Guide'.
setopt NO_mail_warning       # Don't print a warning message if a mail file has been accessed.
setopt NO_beep               # Don't beep on error in line editor.

# Set Zsh options related to job control.
setopt auto_resume           # Attempt to resume existing job before creating a new process.
setopt long_list_jobs        # List jobs in the long format by default.
setopt notify                # Report status of background jobs immediately.
setopt NO_bg_nice            # Don't run all background jobs at a lower priority.
setopt NO_check_jobs         # Don't report on jobs when shell exit.
setopt NO_hup                # Don't kill jobs on shell exit.

# Set reasonable defaults for common shell variables.
export BROWSER="${BROWSER:-open}"

if (( $+commands[nvim] )); then
  export EDITOR="${EDITOR:-nvim}"
elif
  export EDITOR="${EDITOR:-vim}"
fi

if (( $+commands[code] )); then
  export VISUAL="${VISUAL:-code}"
elif (( $+commands[nvim] )); then
  export VISUAL="${VISUAL:-nvim}"
elif
  export VISUAL="${VISUAL:-vim}"
fi

export PAGER="${PAGER:-less}"
export LANG="${LANG:-en_US.UTF-8}"
export LESS="${LESS:--g -i -M -R -S -w -z-4}"

# Reduce key delay
export KEYTIMEOUT=${KEYTIMEOUT:-1}

# Use `< file` to quickly view the contents of any file.
[[ -z "$READNULLCMD" ]] || READNULLCMD=$PAGER

# Set the Less input preprocessor.
# Try both `lesspipe` and `lesspipe.sh` as either might exist on a system.
if [[ -z "$LESSOPEN" ]] && (( $#commands[(i)lesspipe(|.sh)] )); then
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi
