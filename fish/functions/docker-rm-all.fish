function docker-rm-all
  docker ps -a -f status=exited | grep -vP '(\-data|\-storage) *$'| awk '{if(NR>1) print $1}' | xargs -r docker rm
end
