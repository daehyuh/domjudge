# Domjudge 8.3 구축

Docker File 구성
docker-compose.yml
- Mariadb       (데이터베이스)
- Domserver     (웹서버)

docker-compose-checker.yml
- judgehost-0   (채점 서버)
- 필요에 따라 추가 생성 가능


## Useage

### Docker 설치

Set up Docker's apt repository.
``` bash
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
```

Install the Docker packages.
```bash
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```


### Domjudge 설치

Docker File 설치
```bash
git clone https://github.com/daehyuh/domjudge.git
cd domjudge
```

서버 한국시간 기준 변경
``` bash
date
sudo timedatectl set-timezone Asia/Seoul 
```

MariaDB, Domserver 설치
``` bash
sudo docker-compose up -d mariadb domserver
```

DomServer 설치 시 채점서버 비밀번호 확인가능
``` bash
sudo docker exec -it domserver cat /opt/domjudge/domserver/etc/restapi.secret

# Format: '<ID> <API url> <user> <password>'
# default	http://localhost//api	judgehost 7UGT1gp1LsGzRixMQEUmFEKg01POxCWv
```
docker-compose-checker 20번줄 JUDGEDAEMON_PASSWORD에 채점서버 비밀번호 입력

```
sudo vi docker-compose-checker
    - JUDGEDAEMON_PASSWORD=7UGT1gp1LsGzRixMQEUmFEKg01POxCWv
```

채점서버 실행
```bash
sudo docker-compose -f docker-compose-checker.yml up -d
```

# 웹사이트 관리자 로그인

웹 접속을 위한 방화벽 개방
```bash
sudo iptables -I INPUT 1 -p tcp --dport 80 -j ACCEPT
sudo iptables -I INPUT 1 -p tcp --dport 12345 -j ACCEPT
```

DomJudge 접속
[localhost:12345](localhost:12345)

관리자 비밀번호 확인
```
sudo docker exec -it domserver cat /opt/domjudge/domserver/etc/initial_admin_password.secret

# ZTw4t_-OSK4ArGnp
```
아이디 : ADMIN
비밀번호 : ZTw4t_-OSK4ArGnp