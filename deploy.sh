# Reference - https://www.tines.com/blog/simple-zero-downtime-deploys-with-nginx-and-docker-compose/

reload_nginx() {  
  docker exec nginx /usr/sbin/nginx -s reload  
}

zero_downtime_deploy() {  
  service_name=webapp  
  old_container_id=$(docker ps -f name=$service_name -q | tail -n1)

  echo "Bringing a new container up"
  docker compose up -d --no-deps --scale $service_name=2 --no-recreate $service_name

  echo "Checking the health of the new container"  
  new_container_id=$(docker ps -f name=$service_name -q | head -n1)
  new_container_ip=$(docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $new_container_id)
  curl --include --retry-connrefused --retry 30 --retry-delay 1 --fail http://$new_container_ip:3000/ || exit 1

  echo "Start routeing requests to the new container, while the old container still handle requests"  
  reload_nginx

  echo "Stop the old container"
  docker stop $old_container_id
  docker rm $old_container_id

  echo "Stop routing requests to the old container "
  docker compose up -d --no-deps --scale $service_name=1 --no-recreate $service_name

  reload_nginx  
}

zero_downtime_deploy