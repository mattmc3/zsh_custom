0=${(%):-%N}
prompt_name="lean"
if [[ ! -d "${0:A:h}/${prompt_name}" ]]; then
  git clone --depth=1 --recursive https://github.com/miekg/lean.git "${0:A:h}/${prompt_name}"
fi
source "${0:A:h}/${prompt_name}/prompt_${prompt_name}_setup"
fpath+=("${0:A:h}/${prompt_name}")
unset prompt_name
