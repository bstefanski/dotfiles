function profile-cp
  set -l target testbed
  if test (count $argv) = 2
    set target $argv[2]
  end
  extract $argv[1]
  set -l directory_name (basename $argv[1] .zip)
  mv ./$directory_name/p4 .
  cp -a p4/* ~/data/workspace/touk/$target/fabric/profiles/p4
  rm -rf ./p4
  rm -rf $directory_name
end
