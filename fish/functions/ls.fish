# Defined in - @ line 1
function ls --description 'alias ls=exa --header --git --time-style=long-iso'
	exa --header --git --time-style=long-iso $argv;
end
