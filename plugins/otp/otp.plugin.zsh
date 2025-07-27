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
  reply=($(find $OTP_HOME/ -name \*.otp.asc | xargs basename -s .otp.asc))
}

compctl -K __otp_keys otp
