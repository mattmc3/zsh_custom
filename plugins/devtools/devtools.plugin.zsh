#
# Emacs
#

# Add emacs to path
path+=(
  # emacs
  $HOME/.emacs.d/bin(N)
  $XDG_CONFIG_HOME/emacs/bin(N)
)

#
# Go
#

path+=(${GOPATH:-$HOME/go}/bin(N))

#
# Java
#

alias setjavahome="export JAVA_HOME=\`/usr/libexec/java_home\`"

#
# Perl
#

if [[ "$OSTYPE" == darwin* ]]; then
  # eval "$(perl -I$XDG_DATA_HOME/perl5/lib/perl5 -Mlocal::lib=$XDG_DATA_HOME/perl5)"
  export PERL_MB_OPT='--install_base "$XDG_DATA_HOME/perl5"'
  export PERL_MM_OPT='INSTALL_BASE=$XDG_DATA_HOME/perl5'
  if [[ ! -d $XDG_DATA_HOME/perl5 ]]; then
    mkdir -p $XDG_DATA_HOME/perl5
    cpan local::lib
  fi
fi

#
# Postgres
#

# Add postgres to path
path+=(${HOMEBREW_PREFIX:-/opt/homebrew}/opt/postgresql@18/bin(/N))

#
# Ruby
#

# Ruby is keg-only
path+=(
  ${HOMEBREW_PREFIX:-/opt/homebrew}/opt/ruby/bin(N)
  ${HOMEBREW_PREFIX:-/opt/homebrew}/lib/ruby/gems/*/bin(N)
  $HOME/.gem/ruby/*/bin(N)
)
