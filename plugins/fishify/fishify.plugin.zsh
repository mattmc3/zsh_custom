# fishify: Add Fish commands to Zsh

# Load plugin functions, but only if no command of the same name exists.
0=${(%):-%N}
fpath=(${0:a:h}/functions $fpath)
for _fishify_fn in ${0:a:h}/functions/*(.:t); do
  (( $+commands[$_fishify_fn] )) && continue
  autoload -Uz $_fishify_fn
done
unset _fishify_fn
