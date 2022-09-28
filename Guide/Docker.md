该教程用于在 Docker 中安装 TRSS Yunzai

[![访问量](https://profile-counter.glitch.me/TimeRainStarSky-Docker/count.svg)](https://docker.com)
***
```
bash <(curl -L https://gitee.com/TimeRainStarSky/TRSS_Yunzai/raw/main/Guide/Docker.sh)
```
***
ArchLinux, Debian, Ubuntu 可直接运行脚本，自动安装 Docker

其他发行版请手动安装 Docker <https://docker.com>
***
终端输入 `docker ps`，显示以下内容则表示安装成功
```
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
```
***
## 常见问题
***
```
Cannot connect to the Docker daemon at unix:///var/run/docker.sock
```
若显示以上内容，请先启动 Docker Daemon
```
systemctl enable docker
systemctl start docker
```
***
```
Got permission denied while trying to connect to the Docker daemon socket at unix:///var/run/docker.sock
```
若显示以上内容，请添加当前用户到 docker 组
```
gpasswd -a "$USER" docker
```
***
服务器 Linux 发行版 推荐使用 `Debian 11` 以上

服务器安装视频教程：<https://www.bilibili.com/video/BV1ie4y1b7zE>

若只有 `Debian 10`，可执行以下命令并重启服务器后升级到 `Debian 11`
```
apt update && apt full-upgrade -y
sed -i 's/buster/bullseye/g' /etc/apt/sources.list
apt update && apt full-upgrade -y
apt autoremove --purge -y && apt clean
```