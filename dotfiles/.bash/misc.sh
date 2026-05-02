# make less more friendly for non-text input files, see lesspipe(1)
# so less can be used for *.zip, *.tar, *.pdf, *.png, etc
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
