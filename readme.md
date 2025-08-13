# Domjudge 8.3 구축

### Domjudge 및 Mariadb 설치

서버의 시간 확인
``` bash
date
sudo timedatectl set-timezone Asia/Seoul

# python3-setuptools
sudo apt install python3-setuptools
```

MariaDB, Domserver 설치
``` bash
sudo docker compose up -d mariadb domserver
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
docker compose -f docker-compose-checker.yml up -d
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
