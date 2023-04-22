#
# zfunctions - Use a Fish-like functions directory for zsh functions.
#

# Load plugins functions.
fpath=("${0:A:h}/functions" $fpath)
autoload -Uz $fpath[1]/*(.:t)

# Set ZFUNCDIR.
: ${ZFUNCDIR:=${ZDOTDIR:-${XDG_CONFIG_HOME:-~/.config/zsh}}/functions}
[[ -d "$ZFUNCDIR" ]] || return 1

# Load zfunctions subdirs.
for _fndir in $ZFUNCDIR(N/) $ZFUNCDIR/*(N/); do
  fpath=("$_fndir" $fpath)
  autoload -Uz $fpath[1]/*(.:t)
done
unset _fndir
