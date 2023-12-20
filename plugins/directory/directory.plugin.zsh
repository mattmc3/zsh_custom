#
# directory - Sets directory options and defines directory aliases.
#

#
# References
#

# https://github.com/sorin-ionescu/prezto/blob/master/modules/directory/init.zsh

#
# Options
#

# 16.2.1 Changing Directories
setopt auto_pushd              # Make cd push the old directory onto the dirstack.
setopt pushd_ignore_dups       # Don’t push multiple copies of the same directory onto the dirstack.
setopt pushd_minus             # Exchanges meanings of +/- when navigating the dirstack.
setopt pushd_silent            # Do not print the directory stack after pushd or popd.
setopt pushd_to_home           # Push to home directory when no argument is given.
setopt multios                 # Write to multiple descriptors.
setopt glob_dots               # Don't hide dotfiles from glob patterns.
setopt extended_glob           # Use extended globbing syntax.
setopt NO_clobber              # Don't overwrite files with >. Use >| to bypass.
setopt NO_rm_star_silent       # Ask for confirmation for `rm *' or `rm path/*'

#
# Aliases
#

if ! zstyle -t ':mattmc3:zsh_custom:plugin:directory:alias' skip; then
  alias -- -='cd -'
  alias dirh='dirs -v'
  for _idx in {1..9}; do
    alias "$_idx"="cd +${_idx}"
    alias -g "..$_idx"=$(printf '../%.0s' {1..$_idx})
  done
  unset _idx
fi
