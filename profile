#!/bin/sh

PATH=$PATH:$HOME/bin
PATH=$PATH:$HOME/.rvm/bin
PATH=$PATH:$HOME/.cabal/bin

export JAVA_HOME=/usr/lib/jvm/default
export IDEA_JDK=/usr/lib/jvm/default
export SDKMAN_DIR=/home/bartekmanj/.sdkman

export EDITOR="/usr/bin/vim"

export BROWSER=/usr/bin/xdg-open

[ -f ~/.bashrc ] && . ~/.bashrc
