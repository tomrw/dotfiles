nukeDocker() {
	docker rm -f $(docker ps -a -q)
	docker rmi -f $(docker images -a -q)
	docker volume rm $(docker volume ls -q)
	docker network rm $(docker network ls | tail -n+2 | awk '{if($2 !~ /bridge|none|host/){ print $1 }}')
}

dockerIp() {
	docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $1
}

dockerInspect() {
	docker exec -it $1 ash
}
