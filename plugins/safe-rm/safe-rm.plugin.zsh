export PATH="$ZSH_CUSTOM/.external/kaelzhang/shell-safe-rm/bin:$PATH"

# prefer del
alias del="rm.sh"

# for if you forget and use rm
alias rm="echo stop using rm, use del; false"
