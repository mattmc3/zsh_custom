# The JVM echoes "Picked up _JAVA_OPTIONS: ..." to stderr on every run, which
# some scripts and CI parsers choke on.
# old: ~/.java
export _JAVA_OPTIONS=${_JAVA_OPTIONS:--Djava.util.prefs.userRoot=$XDG_CONFIG_HOME/java}
