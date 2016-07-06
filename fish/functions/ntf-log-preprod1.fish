function ntf-log-preprod1
	ssh preprod0 -t 'less fabric8/instances/pnotifier1/data/log/karaf.log'
end
