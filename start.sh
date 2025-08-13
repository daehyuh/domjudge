sudo docker compose start mariadb domserver

sudo echo "RESTAPI_PASSWORD=$(sudo sh checkpass.sh | awk 'NF {print $NF}')" >> .env

sudo docker compose -f docker-compose-checker.yml up -d