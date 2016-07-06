function ntf-log-preprod2
	ssh preprod2 -t 'less /opt/esb/fabric8/instances/pnotifier2/data/log/karaf.log'
end
