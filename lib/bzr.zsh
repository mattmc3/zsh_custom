# hollowed out - uses lazy loading

# since this is the first file, add the functions dir for autoload
fpath=("$ZSH_CUSTOM"/functions $fpath);
autoload -U "$ZSH_CUSTOM"/functions/*(.:t)
