# pure prompt
set -xU pure_color_mute (set_color 93A1A1)
set -xU pure_color_success (set_color green)

# man colors
set -xU LESS_TERMCAP_md (printf "\e[01;31m")
set -xU LESS_TERMCAP_me (printf "\e[0m")
set -xU LESS_TERMCAP_se (printf "\e[0m")
set -xU LESS_TERMCAP_so (printf "\e[01;44;33m")
set -xU LESS_TERMCAP_ue (printf "\e[0m")
set -xU LESS_TERMCAP_us (printf "\e[01;32m")

source /opt/asdf-vm/asdf.fish
source ~/.asdf/plugins/java/set-java-home.fish

set fish_greeting
