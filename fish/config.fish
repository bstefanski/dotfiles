# Path to Oh My Fish install.
set -gx OMF_PATH /home/bartekmanj/.local/share/omf

# Customize Oh My Fish configuration path.
#set -gx OMF_CONFIG /home/bartekmanj/.config/omf

set -g Z_SCRIPT_PATH /usr/lib/z.sh

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
set __fish_git_prompt_char_dirtystate '⚡'
set __fish_git_prompt_char_untrackedfiles '?'
set __fish_git_prompt_char_stagedstate '→'
set __fish_git_prompt_char_stashstate '↩'
set __fish_git_prompt_char_upstream_ahead '↑'
set __fish_git_prompt_char_upstream_behind '↓'
set __fish_git_prompt_char_upstream_equal '='
set __fish_git_prompt_char_upstream_diverged '><'

# Load oh-my-fish configuration.
source $OMF_PATH/init.fish

set fish_greeting
