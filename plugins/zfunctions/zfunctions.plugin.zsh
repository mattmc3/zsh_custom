#
# zfunctions - Use a Fish-like functions directory for zsh functions.
#

# Load plugins functions.
fpath=("${0:A:h}/functions" $fpath)
autoload -Uz $fpath[1]/*(.:t)

# Set ZFUNCDIR.
: ${ZFUNCDIR:=$ZSH_CUSTOM/functions}
[[ -d "$ZFUNCDIR" ]] || ZFUNCDIR=$ZDOTDIR/functions

# Load zfunctions subdirs.
for _fndir in $ZFUNCDIR(N/) $ZFUNCDIR/*(N/); do
  fpath=("$_fndir" $fpath)
  autoload -Uz $fpath[1]/*(.:t)
done
unset _fndir
