#
# confd - Source all zsh files from a Fish-like conf.d directory
#

for confd in $ZSH_CUSTOM/conf.d/*.zsh(.N); do
  # ignore files that begin with ~
  case ${confd:t} in '~'*) continue;; esac
  source $confd
done
unset confd
