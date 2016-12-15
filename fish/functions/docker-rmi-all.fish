function docker-rmi-all
  docker images -a | grep -v filemon/oracle_11g | awk '{if(NR>1) print $3}' | xargs -r docker rmi
end
