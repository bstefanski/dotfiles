function docker_kill_all
	docker stop (docker ps -a -q)
end
