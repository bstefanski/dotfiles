function docker-rmi-all
  docker images -a | awk '{if(NR>1) print $3}' | xargs -r docker rmi
end
