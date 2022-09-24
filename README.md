<div align="center">

[![亚托莉](Picture/亚托莉.png)](https://moegirl.org.cn/亚托莉)

# TRSS Yunzai
云崽机器人管理脚本

[![Stars](https://img.shields.io/github/stars/TimeRainStarSky/TRSS_Yunzai?color=yellow&label=收藏)](../../stargazers)
[![Downloads](https://img.shields.io/github/downloads/TimeRainStarSky/TRSS_Yunzai/total?color=blue&label=下载)](Install.sh)
[![Releases](https://img.shields.io/github/v/release/TimeRainStarSky/TRSS_Yunzai?color=green&label=发行版)](../../releases/latest)

[![访问量](https://profile-counter.glitch.me/TimeRainStarSky-TRSS_Yunzai/count.svg)](https://github.com/TimeRainStarSky/TRSS_Yunzai)

</div>

## 使用教程
1. 准备：[Arch Linux](https://archlinux.org)
- [Windows](https://www.microsoft.com/windows) 推荐使用 [Guide/ArchWSL.md](Guide/ArchWSL.md)
- [Linux](https://kernel.org) 和 [Mac](https://apple.com/mac) 推荐使用 [Guide/Docker.md](Guide/Docker.md)
- [Android Termux](https://github.com/termux/termux-app) 推荐使用 [Guide/TMOE.md](Guide/TMOE.md)

2. 安装：
```
bash <(curl -L https://gitee.com/TimeRainStarSky/TRSS_Yunzai/raw/main/Install.sh)
```

3. 启动：`tsyz`

视频教程：<https://bilibili.com/av983453309>

## 使用说明
- [Yunzai](https://github.com/Le-niao/Yunzai-Bot) <-调用-> [OICQ](https://oicqjs.github.io/oicq) <-网络连接-> [QQ服务器](https://im.qq.com)
- [OICQ](https://oicqjs.github.io/oicq)：提供QQ账号管理，收发消息等功能
- [Yunzai](https://github.com/Le-niao/Yunzai-Bot)：对消息进行处理，完成目标操作

## 常见问题
- 问：发消息错误：46
- 答：账号被风控

- 问：请先开启 Redis
- 答：脚本会自动在后台启动 Redis，如果遇到这种情况，说明 Redis 未正常启动，请在终端中输入`redis-server`查看具体问题

- 问：address already in use
- 答：端口被占用，请尝试停止占用进程、重启设备，或修改配置文件，更改端口

- 问：open terminal failed: not a terminal
- 答：TMOE PRoot 容器首次启动会出现，重启容器就行了

- 问：[server exited unexpectedly]
- 答：tmux 进程意外退出，可能是系统资源不足引起的，如果在 Termux 中经常出现，请检查设置：电池优化、后台运行权限

- 问：我有其他问题
- 答：提供详细问题描述，通过下方 联系方式 反馈问题

## 联系方式
- QQ群组：[211414032](https://jq.qq.com/?k=QU1xGLEB)
### 时雨🌌星空
- GitHub：[TimeRainStarSky](https://github.com/TimeRainStarSky)
- 酷安：[时雨丶星空](http://www.coolapk.com/u/2650948)
- QQ：[2536554304](https://qm.qq.com/cgi-bin/qm/qr?k=x8LtlP8vwZs7qLwmsbCsyLoAHy7Et1Pj)
- Telegram：[TimeRainStarSky](https://t.me/TimeRainStarSky)

## 赞助支持
- 爱发电：<https://afdian.net/a/TimeRainStarSky>
- Partme：<https://partme.com/TimeRainStarSky>

## 界面展示
[![主界面](Picture/Main.png)](https://github.com/TimeRainStarSky/TRSS_Yunzai)
[![Yunzai2](Picture/Yunzai2.png)](https://github.com/TimeRainStarSky/Yunzai-Bot-2)
[![Yunzai3](Picture/Yunzai3.png)](https://github.com/Le-niao/Yunzai-Bot)
[![Adachi](Picture/Adachi.png)](https://docs.adachi.top)

## 相关项目
[![TRSS Liteyuki 管理脚本](https://github-readme-stats.vercel.app/api/pin/?username=TimeRainStarSky&repo=TRSS_Liteyuki&show_owner=true)](../../../TRSS_Liteyuki)
[![TRSS Yunzai 管理脚本](https://github-readme-stats.vercel.app/api/pin/?username=TimeRainStarSky&repo=TRSS_Yunzai&show_owner=true)](../../../TRSS_Yunzai)
[![TRSS Sagiri 管理脚本](https://github-readme-stats.vercel.app/api/pin/?username=TimeRainStarSky&repo=TRSS_Sagiri&show_owner=true)](../../../TRSS_Sagiri)
[![TRSS OneBot 管理脚本](https://github-readme-stats.vercel.app/api/pin/?username=TimeRainStarSky&repo=TRSS_OneBot&show_owner=true)](../../../TRSS_OneBot)