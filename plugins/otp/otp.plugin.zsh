#
# otp - One-time passwords (multi-factor authentication from the command line)
#

#
# References
#

# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/otp

#
# Variables
#

export OTP_HOME="${OTP_HOME:-${XDG_DATA_HOME:-$HOME/.local/share}/otp}"
[[ -d $OTP_HOME ]] || mkdir -p $OTP_HOME

function otp {
  if ! command -v oathtool > /dev/null 2>&1; then
    echo >&2 "otp: 'oathtool' not found. Install oathtool or oath-toolkit, depending on your OS."
    return 1
  fi

  if ! command -v gpg > /dev/null 2>&1; then
    echo >&2 "otp: 'gpg' not found. Install, and create a key with 'gpg --gen-key' if you don't already have one."
    return 1
  fi

  local -a gpg_keys
  zstyle -a ':zsh_custom:plugin:otp' recipents 'gpg_keys'

  local -a gpg_recipients=()
  local recp
  for recp in $gpg_keys; do
    gpg_recipients+=(--recipient "$recp")
  done

  local -a flag_help flag_add flag_list
  local usage=(
    "usage: otp [-h | --help] [-l | --list] [-a | --add] <key>"
  )
  zmodload zsh/zutil
  zparseopts -D -F -K -- \
    {h,-help}=flag_help \
    {l,-list}=flag_list \
    {a,-add}=flag_add || {
      print -u 2 "Run 'opt -h' for usage."
      return 1
    }

  if (( $#flag_help )); then
    print -l -- $usage
    return
  elif (( $#flag_list )); then
    local file
    for file in $OTP_HOME/*.otp.asc; do
      print -- $file:t:r:r
    done
  elif [[ -z "$1" ]]; then
    print -u 2 "otp: Expecting <key> argument. Run 'opt -h' for usage."
    return 1
  elif (( $#flag_add )); then
    echo "The 'otp' utility works by using gpg to encrypt your OTP key."
    echo "First, enter the email address associated your GPG private key. You can add multiple."
    echo "When done, press enter to end with an empty line."
    echo "Next, you will paste your OTP secret key, followed by ^D to end the GPG message."
    rm -f $OTP_HOME/$1.otp.asc
    gpg ${=gpg_recipients} --armor --encrypt --output $OTP_HOME/$1.otp.asc /dev/stdin
  elif [[ ! -f $OTP_HOME/$1.otp.asc ]]; then
    echo "otp: missing key '$1'. Run 'otp --add <key>' to add a new one-time password."
    return 1
  else
    totpkey=$(gpg --quiet --decrypt $OTP_HOME/$1.otp.asc)
    oathtool --totp --b $totpkey | tee /dev/stderr | clipcopy
  fi
}


#
# Completions
#

function __otp_keys {
  reply=($(find $OTP_HOME/ -name \*.otp.asc | xargs basename -s .otp.asc))
}

compctl -K __otp_keys otp
