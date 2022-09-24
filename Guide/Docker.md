该教程用于在 Docker 中安装 TRSS Yunzai

[![访问量](https://profile-counter.glitch.me/TimeRainStarSky-Docker/count.svg)](https://docker.com)
***
```
bash <(curl -L https://gitee.com/TimeRainStarSky/TRSS_Yunzai/raw/main/Guide/Docker.sh)
```
***
服务器 Linux 发行版 推荐使用`Debian 11`以上，如果只有`Debian 10`，可执行以下命令升级`Debian 11`后重启服务器即可
```
apt update && apt full-upgrade -y
sed -i 's/buster/bullseye/g' /etc/apt/sources.list
apt update && apt full-upgrade -y
apt autoremove --purge -y && apt clean
```