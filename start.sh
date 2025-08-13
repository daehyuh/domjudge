sudo docker compose -f domjudge/docker-compose.yml up -d
rm checker/.env
sudo echo "RESTAPI_PASSWORD=$(sudo sh checkpass.sh 2>&1 | tr -s ' \n' ' ' | awk '{print $NF}')" >> checker/.env
sudo docker compose -f checker/docker-compose-checker.yml up -d



echo 어드민 패스워드 확인 중...
echo ID : admin
echo password : $(sudo docker exec -it domserver cat /opt/domjudge/domserver/etc/initial_admin_password.secret)

hostname -I | awk '{print $1}':12345