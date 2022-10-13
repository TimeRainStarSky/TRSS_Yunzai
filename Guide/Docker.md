该教程用于在 Docker 中安装 TRSS Yunzai

[![访问量](https://profile-counter.glitch.me/TimeRainStarSky-Docker/count.svg)](https://docker.com)

## 容器安装

1. 安装 [Docker](https://docker.com)

- ArchLinux, Debian, Ubuntu 可直接运行脚本，自动安装 Docker
- 终端输入 `docker ps`，显示以下内容则表示安装成功

```
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
```

2. 安装容器

```
bash <(curl -L https://gitee.com/TimeRainStarSky/TRSS_Yunzai/raw/main/Guide/Docker.sh)
```

## 容器管理

- 启动容器：`docker start TRSS_Yunzai`（默认为开机自启，无需手动启动）
- 停止容器：`docker stop -t 0 TRSS_Yunzai`
- 删除容器：`docker rm TRSS_Yunzai`
- 重建容器：

```
docker run -itPd
  -h TRSS-Yunzai #主机名
  --name TRSS_Yunzai #容器名
  -v ~/TRSS_Yunzai:/root/TRSS_Yunzai #数据映射
  --restart=always #自启动
  -p 2536:80 #端口映射
  trss:yunzai
```

## 常见问题

```
Cannot connect to the Docker daemon at unix:///var/run/docker.sock
```

若显示以上内容，请先启动 Docker Daemon

```
systemctl enable docker
systemctl start docker
```

---

```
Got permission denied while trying to connect to the Docker daemon socket at unix:///var/run/docker.sock
```

若显示以上内容，请添加当前用户到 docker 组

```
sudo gpasswd -a "$USER" docker
```

---

服务器 Linux 发行版 推荐使用 `Debian 11` 以上

服务器安装视频教程：<https://bilibili.com/video/BV1ie4y1b7zE>

若只有 `Debian 10`，可执行以下命令并重启服务器后升级到 `Debian 11`

```
apt update && apt full-upgrade -y
sed -i 's/buster/bullseye/g' /etc/apt/sources.list
apt update && apt full-upgrade -y
apt autoremove --purge -y && apt clean
```
