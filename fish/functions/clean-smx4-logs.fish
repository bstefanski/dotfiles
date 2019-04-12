function clean-smx4-logs
  cd ~/data/workspace/touk/
  set logs_size (find . \( -iname "logstash.log*" -o -iname "karaf.log*" \) -type f -exec du -ch {} + | grep total | cut -d ' ' -f 1)
  test -n "$logs_size" || set logs_size "0 MB"
  find . \( -iname "logstash.log*" -o -iname "karaf.log*" \) -type f -delete
  echo Removed files size: $logs_size
  cd -
end
