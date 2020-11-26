for _f in "${0:A:h}/functions"/*(.N); do
  autoload -Uz "$_f"
done
unset _f
