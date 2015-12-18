function docker_rm_all
	docker rm (docker ps -a -q)
end
