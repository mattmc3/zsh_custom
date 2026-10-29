# zsh-bench has no plugin file for omz-plus to load, so clone it here. Living in
# repos/ means `omz+ update` pulls it.
_zsh_bench_dir=${ZSH_CUSTOM:-$ZSH/custom}/repos/zsh-bench
[[ -d $_zsh_bench_dir ]] ||
  git clone -q --depth 1 https://github.com/romkatv/zsh-bench $_zsh_bench_dir
path+=($_zsh_bench_dir)
unset _zsh_bench_dir
