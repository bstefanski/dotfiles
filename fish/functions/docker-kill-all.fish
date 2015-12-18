function docker-kill-all
	docker kill (docker ps -a -q)
end
