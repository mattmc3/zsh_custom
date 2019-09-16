# hollowed out - uses lazy loading

# since this is the first file, add the functions dir for autoload
fpath=("$ZSH_CUSTOM"/lib/functions $fpath);
autoload -U "$ZSH_CUSTOM"/lib/functions/*(.:t)
