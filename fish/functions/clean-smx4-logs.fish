function clean-smx4-logs
	cd ~/data/workspace/touk/
sudo find . \( -iname "logstash.log*" -o -iname "karaf.log*" \) -exec rm -rf '{}' \;
cd -
end
