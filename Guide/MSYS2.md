该教程用于在 Windows MSYS2 中安装 TRSS Yunzai

[![访问量](https://visitor-badge.glitch.me/badge?page_id=TimeRainStarSky.TRSS_Yunzai-MSYS2&right_color=red&left_text=访%20问%20量) ![访问量](https://profile-counter.glitch.me/TimeRainStarSky-TRSS_Yunzai-MSYS2/count.svg)](https://msys2.org)

---

1. 准备：[MSYS2 UCRT64](https://msys2.org)

- [GitHub Proxy 镜像源](https://ghproxy.com/github.com/msys2/msys2-installer/releases/download/nightly-x86_64/msys2-x86_64-latest.exe)

2. 安装（首次安装可能会自动关闭，再次启动即可）：

```
bash <(curl -L gitee.com/TimeRainStarSky/TRSS_Yunzai/raw/main/Install-MSYS2.sh)
```

3. 启动：`tsyz`

## 常见问题

- 问：未能同步所有数据库（无法锁定数据库）
- 答：右键 `以管理员身份运行` 或 `rm /var/lib/pacman/db.lck`

- 问：无法提交处理（无效或已损坏的软件包）
- 答：`pacman -Syy msys2-keyring`