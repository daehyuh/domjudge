# Domjudge 8.3 구축
<img src="https://github.com/user-attachments/assets/5d719eac-a754-4caf-824f-4d395670404a" width="75%">

Docker File 구성
docker-compose.yml
- Mariadb       (데이터베이스)
- Domserver     (웹서버)

docker-compose-checker.yml
- judgehost-0   (채점 서버)
- 필요에 따라 추가 생성 가능


## Useage

### 우분투 환경에서의 Docker 설치

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

```bash
curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version
```

```bash
sudo systemctl start docker
```

### 윈도우 환경에서는 Docker를 실행해줘야하
docker desktop 실행

```bash
docker info
```


### Domjudge 및 Mariadb 설치

Docker File 설치
```bash
git clone https://github.com/daehyuh/domjudge.git
cd domjudge
```

서버 한국시간 기준 변경
``` bash
date
sudo timedatectl set-timezone Asia/Seoul

# python3-setuptools
sudo apt install python3-setuptools
```

MariaDB, Domserver 설치
``` bash
sudo docker-compose up -d mariadb domserver
```


한국시간대인지 확인해보기
``` bash
docker exec -it domserver bash
date
```


DomServer 설치 시 채점서버 비밀번호 확인가능
``` bash
docker exec -it domserver cat /opt/domjudge/domserver/etc/restapi.secret

# Format: '<ID> <API url> <user> <password>'
# default	http://localhost//api	judgehost <비밀번호>
```

docker-compose-checker(채점서버)에 비밀번호를 넣는다
```
- JUDGEDAEMON_PASSWORD= <비밀번호>
```

채점서버 실행
```bash
docker-compose -f docker-compose-checker.yml up -d
```

# 웹사이트 관리자 로그인

웹 접속을 위한 방화벽 개방 (환경마다 다를 수 있음)
```bash
sudo ufw allow 12345
```

DomJudge 접속
[localhost:12345](localhost:12345)

관리자 비밀번호 확인
```
docker exec -it domserver cat /opt/domjudge/domserver/etc/initial_admin_password.secret

# <관리자 비빌번호>
```
아이디 : ADMIN
비밀번호 : <관리자 비밀번호 >
