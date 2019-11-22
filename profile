#!/bin/sh

PATH=$PATH:$HOME/bin
if [ -d "$HOME/data/workspace/touk/bin" ]; then
  PATH=$PATH:$HOME/data/workspace/touk/bin
fi

export JAVA_HOME=/usr/lib/jvm/default

export EDITOR="/usr/bin/vim"

export BROWSER=/usr/bin/xdg-open

[ -f ~/.bashrc ] && . ~/.bashrc
