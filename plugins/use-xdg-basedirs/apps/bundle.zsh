# BUNDLE_USER_CONFIG names a file, not a directory.
# old: ~/.bundle
export BUNDLE_USER_CONFIG=${BUNDLE_USER_CONFIG:-$XDG_CONFIG_HOME/bundle/config}
# old: ~/.bundle
export BUNDLE_USER_CACHE=${BUNDLE_USER_CACHE:-$XDG_CACHE_HOME/bundle}
# old: ~/.bundle
export BUNDLE_USER_PLUGIN=${BUNDLE_USER_PLUGIN:-$XDG_DATA_HOME/bundle}
