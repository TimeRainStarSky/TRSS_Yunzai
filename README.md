# TRSS Yunzai 云崽机器人管理脚本
[![Stars](https://img.shields.io/github/stars/TimeRainStarSky/TRSS_Yunzai?color=yellow&label=收藏)](https://github.com/TimeRainStarSky/TRSS_Yunzai/stargazers)
[![Downloads](https://img.shields.io/github/downloads/TimeRainStarSky/TRSS_Yunzai/total?color=blue&label=下载)](https://gitee.com/TimeRainStarSky/TRSS_Yunzai/raw/main/Install.sh)
[![Releases](https://img.shields.io/github/v/release/TimeRainStarSky/TRSS_Yunzai?color=green&label=发布版本)](https://github.com/TimeRainStarSky/TRSS_Yunzai/releases/latest)  
[![访问量](https://profile-counter.glitch.me/TimeRainStarSky-TRSS_Yunzai/count.svg)](https://timerainstarsky.github.io/TRSS_Yunzai)

## 使用教程
1. 准备：[Arch Linux](https://archlinux.org) 推荐使用[TMOE](https://gitee.com/mo2/linux)安装：
```
bash -c "$(curl -L https://gitee.com/mo2/linux/raw/2/2)"
```

2. 安装：
```
curl -LO "https://gitee.com/TimeRainStarSky/TRSS_Yunzai/raw/main/Install.sh" && bash Install.sh
```
视频教程：https://b23.tv/av983453309

## 使用说明
- Yunzai <-调用-> OICQ <-网络连接-> QQ服务器
- OICQ：提供QQ账号管理，收发消息等功能
- Yunzai：对消息进行处理，完成目标操作

## 常见问题
- 问：open terminal failed: not a terminal
- 答：
  - 1.TMOE proot 容器首次启动会出现，退出容器重启就行了，推荐使用 chroot 容器
  - 2.Windows 出现这种情况，是你使用的终端不支持 tmux，请换一个终端

- 问：请先开启 Redis
- 答：你的内核版本过旧，无法运行最新版 Redis
  - 1.Linux 请升级内核 或 安装旧版 Redis
  - 2.Android 请在 Termux 中直接安装启动 Redis  
安装：`pkg install redis`  
启动：`redis-server --daemonize yes`

- 问：我有其他问题
- 答：提供详细问题描述，通过下方 联系方式 反馈问题

## 联系方式
- QQ群组：[211414032](https://jq.qq.com/?k=QU1xGLEB)
### 时雨🌌星空
- GitHub：[TimeRainStarSky](https://github.com/TimeRainStarSky)
- 酷安：[时雨丶星空](http://www.coolapk.com/u/2650948)
- QQ：[2536554304](https://qm.qq.com/cgi-bin/qm/qr?k=x8LtlP8vwZs7qLwmsbCsyLoAHy7Et1Pj)
- Telegram：[TimeRainStarSky](https://t.me/TimeRainStarSky)

## 界面展示
[![主界面](https://cdn.jsdelivr.net/gh/TimeRainStarSky/TRSS_Yunzai@main/Picture/Main.png)](https://github.com/TimeRainStarSky/TRSS_Yunzai)
[![Yunzai2](https://cdn.jsdelivr.net/gh/TimeRainStarSky/TRSS_Yunzai@main/Picture/Yunzai2.png)](https://github.com/TimeRainStarSky/Yunzai-Bot-2)
[![Yunzai3](https://cdn.jsdelivr.net/gh/TimeRainStarSky/TRSS_Yunzai@main/Picture/Yunzai3.png)](https://github.com/Le-niao/Yunzai-Bot)