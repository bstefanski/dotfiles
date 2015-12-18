function docker_rmi_all
	docker rmi -f (docker images -q)
end
