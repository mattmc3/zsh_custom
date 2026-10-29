#
# perl
#

# What `perl -Mlocal::lib=<dir>` would print, without the fork or needing
# local::lib installed. cpan then installs into, and perl loads from, <dir>.
_perl5=${XDG_DATA_HOME:-$HOME/.local/share}/perl5
path=($_perl5/bin $path)
export PERL5LIB="$_perl5/lib/perl5${PERL5LIB:+:$PERL5LIB}"
export PERL_LOCAL_LIB_ROOT="$_perl5${PERL_LOCAL_LIB_ROOT:+:$PERL_LOCAL_LIB_ROOT}"
export PERL_MB_OPT="--install_base \"$_perl5\""
export PERL_MM_OPT="INSTALL_BASE=$_perl5"
unset _perl5
