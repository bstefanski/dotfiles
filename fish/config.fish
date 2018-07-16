# Fish git prompt
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_color 'blue'
set __fish_git_prompt_color_branch 'green'
set __fish_git_prompt_color_untrackedfiles 'cyan'
set __fish_git_prompt_color_stagedstate 'green'
set __fish_git_prompt_color_dirtystate 'yellow'
set __fish_git_prompt_showuntrackedfiles  'yes'
set __fish_git_prompt_showupstream 'verbose'

# Status Chars
set __fish_git_prompt_char_dirtystate '*'
set __fish_git_prompt_char_untrackedfiles '?'
set __fish_git_prompt_char_stagedstate '→'
set __fish_git_prompt_char_stashstate '↩'
set __fish_git_prompt_char_upstream_ahead '↑'
set __fish_git_prompt_char_upstream_behind '↓'
set __fish_git_prompt_char_upstream_equal '='
set __fish_git_prompt_char_upstream_diverged '><'

# man colors
set -xU LESS_TERMCAP_md (printf "\e[01;31m")
set -xU LESS_TERMCAP_me (printf "\e[0m")
set -xU LESS_TERMCAP_se (printf "\e[0m")
set -xU LESS_TERMCAP_so (printf "\e[01;44;33m")
set -xU LESS_TERMCAP_ue (printf "\e[0m")
set -xU LESS_TERMCAP_us (printf "\e[01;32m")

set fish_greeting
