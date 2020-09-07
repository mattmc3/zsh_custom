if [[ -z $_Z_DATA ]]; then
  export _Z_DATA="${XDG_DATA_HOME:-$HOME/.local/share}"/.z
  [[ -f "$_Z_DATA" ]] || { mkdir -p $(dirname "$_Z_DATA") && touch $_Z_DATA }
fi

if [[ ! -d "${0:A:h}/external" ]]; then
  git clone --depth=1 --recursive https://github.com/rupa/z.git "${0:A:h}/external"
fi
source "${0:A:h}/external/z.sh"
