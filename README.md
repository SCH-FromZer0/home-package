# FromZer0 Bootstrapper

## Clone시 유의사항
Git submodules를 사용하고 있어서 `--recursive` 옵션을 사용해야 한다.  
예를 들어, git 주소가 `<GIT_REPOSITORY_URL>`이라 가정할 때 다음과 같이 사용한다.  
```bash
git clone --recursive <GIT_REPOSITORY_URL>
```

## 서버 환경에서의 실행
`root` 권한을 가진 상태로 `start.sh` 를 실행하면 자동으로 `Docker` 를 포함하여 모든 패키지를 자동으로 설치하고 서버를 실행한다.

```shell
sudo /bin/bash ./start.sh
```

또는
```shell
sudo su
./start.sh
```


## 서버 환경에서의 종료
`root` 권한을 가진 상태로 `start.sh` 를 실행하면 모든 실행중인 컨테이너를 종료한다.

```bash
sudo /bin/bash ./stop.sh
```

또는
```shell
sudo su
./stop.sh
```

## 강제 리빌드
`Dockerfile`이나 `docker-compose.yml` 을 수정했을 경우, 반영을 위해 강제 리빌드를 수행해야 한다.  
하단 `<client/server>` 부분은 상황에 따라 양자택일 하면 된다.
```shell
cd <client/server>
docker compose build --no-cache
docker-compose up
```

### 리빌드 후 잔존하는 찌꺼지 이미지 제거

`<none>` 라는 이름을 가진 찌꺼기가 남기 때문에 다음 명령으로 삭제해주어야 한다.
```shell
docker rmi $(docker images -f "dangling=true" -q)
```
