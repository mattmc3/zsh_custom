# old: ~/.kube/config
export KUBECONFIG=${KUBECONFIG:-$XDG_CONFIG_HOME/kube/config}
# old: ~/.kube/cache
export KUBECACHEDIR=${KUBECACHEDIR:-$XDG_CACHE_HOME/kube}
