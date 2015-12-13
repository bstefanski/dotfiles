function __fish_rvm_needs_command
  set cmd (commandline -opc)
  if [ (count $cmd) -eq 1 -a $cmd[1] = 'rvm' ]
    return 0
  end
  return 1
end

function __fish_rvm_dealias_rubies
  perl -ne ' chomp($_);
  if( /^ruby-([\d\.]+)-([^@]+)/ ){
    print "$1", "\n", "$1-$2","\n","ruby-$1", "\n", "ruby-$1-$2","\n";
  }elsif( /./ ){
    print $_,"\n"
  }'
end

function __fish_rvm_dealias_rubies_with_gemsets
  perl -ne 'if( /^ruby-([\d\.]+)-([^@]+)@(.+)/ ){
    print "$1", "\n", "$1-$2","\n","ruby-$1", "\n", "ruby-$1-$2","\n";
    print "$1@$3", "\n", "$1-$2@$3","\n","ruby-$1@$3", "\n", "ruby-$1-$2@$3","\n";
  }'
end

function __fish_rvm_comma_seperated_rubies
  set -l rubies (commandline -ct)

  set -l rubies_prefix (echo $rubies | sed -e 's/[^,]*$//' )

  set -l rubies_grep (echo $rubies_prefix | sed -e 's/,/ -e /')

  __fish_rvm_rubies_with_gemsets | sed -e "s/^/$rubies_prefix/" #>&2
end

function __fish_rvm_using_command
  set cmd (commandline -opc)
  if [ (count $cmd) -gt 1 ]
    if [ $argv[1] = $cmd[2] ]
      return 0
    end
  end
  return 1
end

function __fish_rvm_using_ruby
  set cmd (commandline -opc)
  if [ (count $cmd) -eq 2 ]
    return 0
  end
  return 1
end

function __fish_rvm_using_ruby_do
  set cmd (commandline -opc)
  if [ (count $cmd) -ge 3 ]
    set -e cmd[2]
    set -e cmd[1]
    for elem in $cmd
      switch $elem
      case --json --yaml --verbose --summary
      case 'do' ; return 0
      case '*' ; return 1
      end
    end
  end
  return 1
end

function __fish_rvm_known_rubies
  rvm list known_strings | __fish_rvm_dealias_rubies
end

function __fish_rvm_rubies_with_gemsets

  rvm list gemsets strings | __fish_rvm_dealias_rubies_with_gemsets

end

function __fish_rvm_complete_ruby_do_subcommand
  set cmd (commandline -cop) (commandline -ct)

  if [ (count $cmd) -ge 3 ]
    set -e cmd[2]
    set -e cmd[1]
    while [ (count $cmd) -ne 0 ]
      switch $cmd[1]
      case --json --yaml --verbose --summary ; set -e cmd[1];
      case 'do' ; set -e cmd[1]; break ;
      case '*' ; return ;
      end
    end
    printf "%s\n" (complete -C"$cmd")
  end
  return;
end

function __fish_rvm_commands
  echo -n "update
alias
color
benchmark
specs
srcdir
migrate
build
ruby
remove
gemdir
user
debug
fetch
do
current
rubygems
wrapper
gemset
reset
monitor
uninstall
list
pkg
get
rvmrc
install
snapshot
notes
use
disk-usage
repair
tests
info
implode
cron
cleanup
rake
tools
upgrade
reinstall
docs"
end

#complete -f -c rvm -a '(__fish_rvm_comma_seperated_rubies)' -d 'Ruby'
complete -f -c rvm -n '__fish_rvm_needs_command' -a 'all' -d 'Do all the Rubies'
complete -f -c rvm -n '__fish_rvm_needs_command' -a '(__fish_rvm_comma_seperated_rubies)' -d 'Ruby'
complete -f -c rvm -n '__fish_rvm_needs_command' -a '(__fish_rvm_commands)' -d 'Subcommand'

complete -f -c rvm -n '__fish_rvm_needs_command' -a 'use' -d 'Switch ruby'
complete -f -c rvm -n '__fish_rvm_needs_command' -a 'help' -d 'Get help'

complete -f -c rvm -n '__fish_rvm_using_command help' -a '(__fish_rvm_commands)' -d 'Subcommand'

complete -f -c rvm -n '__fish_rvm_using_command use' -a 'system' -d 'System Ruby'
complete -f -c rvm -n '__fish_rvm_using_command use' -a 'default' -d 'Default Ruby'
#complete -f -c rvm -n '__fish_rvm_using_command use' -a '(__fish_rvm_rubies_with_gemsets)' -d 'Ruby'


complete -f -c rvm -n '__fish_rvm_needs_command' -a 'install' -d 'Install ruby'
complete -f -c rvm -n '__fish_rvm_using_command install' -a '(__fish_rvm_known_rubies)' -d 'Ruby'

complete -f -c rvm -n '__fish_rvm_needs_command' -a 'get' -d 'Update rvm'
complete -f -c rvm -n '__fish_rvm_using_command get' -a 'head stable' -d 'RVM branch'

complete -f -c rvm -n '__fish_rvm_using_ruby' -a 'do' -d 'Do'

complete -f -c rvm -n '__fish_rvm_using_ruby_do' --description "Command to run" -x -a "(__fish_rvm_complete_ruby_do_subcommand)"
# Since sudo runs subcommands, it can accept any switches
complete -c rvm -n '__fish_rvm_using_ruby_do' -u