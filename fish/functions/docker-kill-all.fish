function docker_kill_all
	docker kill (docker ps -a -q)
end
