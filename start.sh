sudo docker compose -f domjudge/docker-compose.yml start mariadb domserver

sudo echo "RESTAPI_PASSWORD=$(sudo sh checkpass.sh | awk 'NF {print $NF}')" >> checker/.env

sudo docker compose -f checker/docker-compose-checker.yml up -d