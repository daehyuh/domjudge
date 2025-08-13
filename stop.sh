sudo docker compose -f domjudge/docker-compose.yml stop
sudo docker compose -f checker/docker-compose-checker.yml stop

sudo docker compose -f domjudge/docker-compose.yml rm
sudo docker compose -f checker/docker-compose-checker.yml rm