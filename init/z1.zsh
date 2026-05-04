#!/bin/zsh
# zshrc1 - the first thing you run for modern Zsh

#
# Init
#

0=${(%):-%N}

# Set Zsh location vars.
ZSH_CONFIG_DIR="${ZDOTDIR:-${XDG_CONFIG_HOME:-$HOME/.config}/zsh}"
ZSH_DATA_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/zsh"
ZSH_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
mkdir -p $ZSH_CONFIG_DIR $ZSH_DATA_DIR $ZSH_CACHE_DIR

# Set any zstyles you might use for configuration.
[[ -r ${ZDOTDIR:-$HOME}/.zstyles ]] && \
  source ${ZDOTDIR:-$HOME}/.zstyles

#
# Paths
#

# Ensure path arrays do not contain duplicates.
typeset -gaU cdpath fpath mailpath path prepath

# prepath lets you keep elements at the front of path.
prepath=(
  $HOME/{,s}bin(N)
  $HOME/.local/{,s}bin(N)
)

# path sets where Zsh searches for programs.
path=(
  $prepath
  /opt/{homebrew,local}/{,s}bin(N)
  /usr/local/{,s}bin(N)
  $path
)

# re-path will reset the path order
function re-path() {
  path=($prepath $path)
}

#
# Homebrew
#

# Setup homebrew if it exists on the system.
if (( $+commands[brew] )); then
  # Initialize homebrew.
  source <(brew shellenv)

  # Preserve the desired path order.
  path=($prepath $path)
fi

#
# Environment
#

# Ensure reasonable defaults.
if (( $+commands[open] )); then
  export BROWSER="${BROWSER:-open}"
fi
export PAGER="${PAGER:-less}"
export LANG="${LANG:-en_US.UTF-8}"
export LESS="${LESS:--g -i -M -R -S -w -z-4}"
export EDITOR="${EDITOR:-vim}"
export VISUAL="${VISUAL:-vim}"

# Reduce vi-mode switch lag.
export KEYTIMEOUT=${KEYTIMEOUT:-1}

# Hook lesspipe(.sh) into less so it can handle non-text formats.
if [[ -z "$LESSOPEN" ]] && (( $#commands[(i)lesspipe(|.sh)] )); then
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi

#
# Globbing
#

# 16.2.3 Expansion and Globbing
setopt extended_glob           # Use extended globbing syntax.
setopt glob_dots               # Don't hide dotfiles from glob patterns.

#
# IO
#

# 16.2.6 Input/Output
setopt interactive_comments    # Enable comments in interactive shell.
setopt multios                 # Write to multiple descriptors.
setopt rc_quotes               # Allow 'Hitchhiker''s Guide' instead of 'Hitchhiker'\''s Guide'.
setopt NO_clobber              # Don't overwrite files with >. Use >| to bypass.
setopt NO_mail_warning         # Don't print a warning if a mail file was accessed.
setopt NO_rm_star_silent       # Ask for confirmation for `rm *' or `rm path/*'

#
# History
#

# Set history options.
setopt bang_hist               # Treat the '!' character specially during expansion.
setopt extended_history        # Write the history file in the ':start:elapsed;command' format.
setopt hist_expire_dups_first  # Expire a duplicate event first when trimming history.
setopt hist_find_no_dups       # Do not display a previously found event.
setopt hist_ignore_all_dups    # Delete an old recorded event if a new event is a duplicate.
setopt hist_ignore_space       # Do not record an event starting with a space.
setopt hist_reduce_blanks      # Remove extra blanks from commands added to the history list.
setopt hist_save_no_dups       # Do not write a duplicate event to the history file.
setopt hist_verify             # Do not execute immediately upon history expansion.
setopt inc_append_history      # Write to the history file immediately, not when the shell exits.
setopt NO_hist_beep            # Don't beep when accessing non-existent history.
setopt NO_share_history        # Don't share history between all sessions.

# Set the path to the default history file.
HISTFILE="$ZSH_DATA_DIR/zsh_history"
SAVEHIST=100000  # Set history file size.
HISTSIZE=20000   # Set session history size.

# Use a better history command.
alias history='fc -li'

#
# Color
#

# Built-in zsh colors
autoload -Uz colors && colors

# Colorize man pages.
export LESS_TERMCAP_md=${LESS_TERMCAP_md:-$fg_bold[blue]}   # start bold
export LESS_TERMCAP_mb=${LESS_TERMCAP_mb:-$fg_bold[blue]}   # start blink
export LESS_TERMCAP_so=${LESS_TERMCAP_so:-$'\e[00;47;30m'}  # start standout: white bg, black fg
export LESS_TERMCAP_us=${LESS_TERMCAP_us:-$'\e[04;35m'}     # start underline: underline magenta
export LESS_TERMCAP_se=${LESS_TERMCAP_se:-$reset_color}     # end standout
export LESS_TERMCAP_ue=${LESS_TERMCAP_ue:-$reset_color}     # end underline
export LESS_TERMCAP_me=${LESS_TERMCAP_me:-$reset_color}     # end bold/blink

# Colorize commands
alias grep="grep --color=auto"
alias ls="ls --color=auto"

if (( $+commands[diff] )); then
  alias diff="diff --color"
fi

if (( $+commands[dircolors] )); then
  source <(dircolors --sh)
else
  export CLICOLOR=${CLICOLOR:-1}
  export LSCOLORS=${LSCOLORS:-exfxcxdxbxGxDxabagacad}
fi

# Pick a reasonable default for LS_COLORS if it hasn't been set by this point.
export LS_COLORS="${LS_COLORS:-di=34:ln=35:so=32:pi=33:ex=31:bd=1;36:cd=1;33:su=30;41:sg=30;46:tw=30;42:ow=30;43}"

# Colorize completions.
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

#
# Directory
#

# 16.2.1 Changing Directories
setopt auto_pushd              # Make cd push the old directory onto the dirstack.
setopt pushd_ignore_dups       # Don’t push multiple copies of the same directory onto the dirstack.
setopt pushd_minus             # Exchanges meanings of +/- when navigating the dirstack.
setopt pushd_silent            # Do not print the directory stack after pushd or popd.
setopt pushd_to_home           # Push to home directory when no argument is given.

# Set directory aliases.
alias -- -='cd -'
alias dirh='dirs -v'


#
# Compstyles
#

# Display: menu select, grouped output, descriptions and warnings highlighted.
zstyle ':completion:*' menu select
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:descriptions' format ' %F{purple}-- %d --%f'
zstyle ':completion:*:warnings' format ' %F{yellow}-- no matches found --%f'

# Case-insensitive, then partial-word, then substring matching.
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Path completion polish.
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' special-dirs ..

#
# Completion
#

# 16.2.2 Completion
setopt always_to_end           # Move cursor to the end of a completed word.
setopt auto_list               # Automatically list choices on ambiguous completion.
setopt auto_menu               # Show completion menu on a successive tab press.
setopt auto_param_slash        # If completed parameter is a directory, add a trailing slash.
setopt complete_in_word        # Complete from both ends of a word.
setopt path_dirs               # Perform path search even on command names with slashes.
setopt NO_menu_complete        # Do not autoselect the first completion entry.

# Lazy-load my completions
fpath=($ZSH_CONFIG_DIR/completions(-/FN) $fpath)

# Location of completion file
export ZSH_COMPDUMP=${ZSH_COMPDUMP:-$ZSH_CACHE_DIR/zcompdump}
mkdir -p $ZSH_COMPDUMP:h

# Queue compdef calls until the real compinit runs at the end of .zshrc.
typeset -gHa __compdef_queue=()
function compdef {
  (( $# )) && __compdef_queue+=("${(j: :)${(@q+)@}}")
}

# Wrap compinit to replay our compdef queue when called.
function compinit {
  emulate -L zsh
  setopt local_options extended_glob

  unfunction compinit compdef
  autoload -Uz compinit
  compinit "$@"

  local entry
  for entry in "${__compdef_queue[@]}"; do
    eval "compdef $entry"
  done
  unset __compdef_queue
}

# Use caching for compinit.
function compinit-fast {
  emulate -L zsh
  setopt local_options extended_glob

  # -C skips the function check (and implies -i, the security check skip).
  if [[ -n $ZSH_COMPDUMP(#qNmh-20) ]]; then
    compinit -C -d "$ZSH_COMPDUMP"  # Take the fast path.
  else
    compinit -i -d "$ZSH_COMPDUMP"
    touch "$ZSH_COMPDUMP"  # Always reset the time when we take the slow path.
  fi

  # Recompile only if stale; atomic rename, safe under concurrent shells.
  autoload -Uz zrecompile
  zrecompile -q -p "$ZSH_COMPDUMP" &!
}

#
# Jobs
#

# 16.2.7 Job Control
setopt auto_resume             # Attempt to resume existing job before creating a new process.
setopt long_list_jobs          # List jobs in the long format by default.
setopt notify                  # Report status of background jobs immediately.
setopt NO_bg_nice              # Don't run all background jobs at a lower priority.
setopt NO_check_jobs           # Don't report on jobs when shell exit.
setopt NO_hup                  # Don't kill jobs on shell exit.

#
# Prompt
#

# 16.2.8 Prompt
setopt prompt_subst            # Expand parameters in prompt variables

# Set 2 space indent for each new level in a multi-line script. This can then be
# overridden by a prompt or plugin, but is a better default than Zsh's.
PS2='${${${(%):-%_}//[^ ]}// /  }    '

# Add prompts
fpath+=("${0:a:h}"/prompts(/N))

#
# Editor
#

# 16.2.12 Zle
setopt combining_chars         # Combine 0-len chars with base chars (eg: accents).
setopt NO_beep                 # Don't beep on error in line editor.
setopt NO_flow_control         # Allow ^Q/^S in zsh.

# Treat these characters as part of a word.
WORDCHARS='*?_-.[]~&;!#$%^(){}<>'

# Optional keymap override: set ZSH_BINDKEY to vi or emacs.
bindkey -d
case "${ZSH_BINDKEY:-}" in
  vi)    bindkey -v ;;
  emacs) bindkey -e ;;
  *)                ;;
esac

# Prefer terminal-reported key sequences when available.
zmodload zsh/terminfo 2>/dev/null

# Allow Ctrl+S/Ctrl+Q for shell editing.
if [[ -r ${TTY:-} && -w ${TTY:-} && $+commands[stty] == 1 ]]; then
  stty -ixon <"$TTY" >"$TTY"
fi

# Run bindkey across every keymap. With no args, prints mappings per keymap.
function bindkey-all {
  local keymap=''
  for keymap in $(bindkey -l); do
    [[ "$#" -eq 0 ]] && printf "#### %s\n" "${keymap}" 1>&2
    bindkey -M "${keymap}" "$@"
  done
}

# Bind one widget to multiple key sequences; skip empties.
function bindkey-multiple {
  local widget=$1 seq; shift
  for seq in "$@"; do
    [[ -n "$seq" ]] && bindkey "$seq" "$widget"
  done
}

# Block cursor in vi cmd mode, beam in insert/emacs. Skip on terminals that
# don't grok DECSCUSR.
function update-cursor-style {
  case $TERM in
    xterm*|rxvt*|tmux*|screen*) ;;
    *) [[ -z "$TMUX" ]] && return ;;
  esac

  if bindkey -lL main | grep -q viins; then
    case $KEYMAP in
      vicmd) printf '\e[2 q' ;;
      viins|main) printf '\e[6 q' ;;
    esac
  else
    printf '\e[6 q'
  fi
}
zle -N update-cursor-style

# Enable terminal application mode so $terminfo key sequences are valid.
function zle-line-init {
  (( $+terminfo[smkx] )) && echoti smkx
  zle update-cursor-style
}
zle -N zle-line-init

function zle-line-finish {
  (( $+terminfo[rmkx] )) && echoti rmkx
}
zle -N zle-line-finish

function zle-keymap-select {
  zle update-cursor-style
  zle reset-prompt
  zle -R
}
zle -N zle-keymap-select

# Insert 'sudo ' at the beginning of the line.
function prepend-sudo {
  if [[ "$BUFFER" != su(do|)\ * ]]; then
    BUFFER="sudo $BUFFER"
    (( CURSOR += 5 ))
  fi
}
zle -N prepend-sudo

# Toggle a leading '#' on the current line. Workaround for buggy pound-insert
# in emacs mode; vi mode uses the built-in vi-pound-insert.
function pound-toggle {
  if [[ "$BUFFER" = '#'* ]]; then
    [[ $CURSOR != $#BUFFER ]] && (( CURSOR -= 1 ))
    BUFFER="${BUFFER:1}"
  else
    BUFFER="#$BUFFER"
    (( CURSOR += 1 ))
  fi
}
zle -N pound-toggle

# Edit current command in $EDITOR.
autoload -Uz edit-command-line
zle -N edit-command-line

# Auto-quote URLs on paste and as you type (prevents ? and & from globbing).
autoload -Uz bracketed-paste-url-magic
zle -N bracketed-paste bracketed-paste-url-magic
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

# Common terminal key fixes: terminfo first, xterm CSI fallbacks second.
bindkey-multiple beginning-of-line "${terminfo[khome]-}" '^[[H'
bindkey-multiple end-of-line       "${terminfo[kend]-}"  '^[[F'
bindkey-multiple delete-char       "${terminfo[kdch1]-}" '^[[3~'
bindkey-multiple backward-word     '^[[1;3D' '^[[1;5D'   # Alt/Ctrl + Left
bindkey-multiple forward-word      '^[[1;3C' '^[[1;5C'   # Alt/Ctrl + Right

# Backspace and word deletion.
bindkey '^?' backward-delete-char
bindkey '^W' backward-kill-word

# Edit command in $EDITOR.
bindkey '^X^E' edit-command-line

# Toggle comment at start of line. Alt-; in emacs, # in vi cmd mode.
bindkey -M emacs '^[;' pound-toggle
bindkey -M vicmd '#' vi-pound-insert

# Prepend sudo with Alt-s.
bindkey -M emacs '^[s' prepend-sudo
bindkey -M viins '^[s' prepend-sudo

#
# Utility
#

# Replace the stub run-help (aliased to man) with the real autoload version.
(( $+aliases[run-help] )) && unalias run-help
autoload -Uz run-help
alias help=run-help

# Lazy-load my functions.
ZFUNCDIR=${ZFUNCDIR:-$ZSH_CONFIG_DIR/functions}
for _zfndir in $ZFUNCDIR(-/FN) $ZFUNCDIR/*(-/FN); do
  fpath=($_zfndir $fpath)
  autoload -Uz $_zfndir/*~*/_*(N.:t)
done
unset _zfndir
