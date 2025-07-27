#
# otp - One-time passwords (multi-factor authentication from the command line)
#

# References
# - https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/otp

! zstyle -t ':zsh_custom:plugin:otp' loaded || return 1


export OTP_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/otp"
function otp {
  "$ZSH_CUSTOM/plugins/otp/bin/otp" "$@"
}

zstyle ':zsh_custom:plugin:otp' loaded 'yes'

#
# Completions
#

function __otp_keys {
  local flags
  flags=(
    -h --help
    -l --list
    -a --add
    -r --remove
    --rekey
  )
  local keys
  keys=($(find $OTP_HOME/ -name '*.otp.asc' | xargs -n1 basename | sed 's/\.otp\.asc$//'))
  reply=(${flags[@]} ${keys[@]})
}

compctl -K __otp_keys otp
