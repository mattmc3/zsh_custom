0=${(%):-%N}
if [[ ! -d "${0:A:h}/lean" ]]; then
  git clone --depth=1 --recursive https://github.com/miekg/lean.git "${0:A:h}/lean"
fi
source "${0:A:h}/lean/prompt_lean_setup"
