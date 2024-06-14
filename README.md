# FromZer0 Bootstrapper

## Clone시 유의사항
Git submodules를 사용하고 있어서 `--recursive` 옵션을 사용해야 한다.  
예를 들어, git 주소가 `<GIT_REPOSITORY_URL>`이라 가정할 때 다음과 같이 사용한다.  
```bash
git clone --recursive <GIT_REPOSITORY_URL>
```

## 서버 환경에서의 실행
`root` 권한을 가진 상태로 `start.sh` 를 실행하면 자동으로 `Docker` 를 포함하여 모든 패키지를 자동으로 설치하고 서버를 실행함.   

```bash
sudo /bin/bash ./start.sh
```
  
또는  
```bash
sudo su
./start.sh
```
