#
# zsh_custom - Use Zsh custom.
#

# Initialize profiling.
[[ "$ZPROFRC" -ne 1 ]] || zmodload zsh/zprof
alias zprofrc="ZPROFRC=1 zsh"

# Make sure ZSH_CUSTOM is properly set.
0=${(%):-%N}
: ${ZSH_CUSTOM:=${0:a:h}}

# Initialize
for zlib in $ZSH_CUSTOM/lib/*.zsh; do
  source $zlib
done
unset zlib
