#
# zfunctions - Use a Fish-like functions directory for zsh functions.
#

# Load this plugin's functions.
autoload-dir "${0:a:h}/functions"

# Set ZFUNCDIR.
: ${ZFUNCDIR:=$__zsh_config_dir/functions}

# Load zfunctions and any subdirs (F-full, N-nullglob, /-dirs).
autoload-dir $ZFUNCDIR(FN/) $ZFUNCDIR/*(FN/)
