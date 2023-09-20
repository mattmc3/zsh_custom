#
# zfunctions - Use a Fish-like functions directory for zsh functions.
#

# Load plugins functions.
fpath=("${0:A:h}/functions" $fpath)
autoload -Uz ${0:A:h}/functions/*(.:t)

# Set ZFUNCDIR.
: ${ZFUNCDIR:=$ZSH_CUSTOM/functions}
[[ -d "$ZFUNCDIR" ]] || ZFUNCDIR=$ZDOTDIR/functions

# Load zfunctions subdirs.
for _fndir in $ZFUNCDIR(FN/) $ZFUNCDIR/*(FN/); do
  fpath=($_fndir $fpath)
  autoload -Uz $_fndir/*(.:t)
done
unset _fndir
