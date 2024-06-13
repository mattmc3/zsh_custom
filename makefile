# Do not remove ##? comments. They are used by 'help' to construct the help docs.
##? prompt - zsh prompt initialization plugin
##?
##? Usage:  make <command>"
##?
##? Commands:

.DEFAULT_GOAL := help
all : help update
.PHONY : all

##? help            display this makefile's help information
help:
	@grep "^##?" makefile | cut -c 5-

##? update          update all the things that need updated
update:
	./bin/update_completions
