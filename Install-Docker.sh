#TRSS Yunzai Docker 安装脚本 作者：时雨🌌星空
NAME=v1.0.0;VERSION=202303120
R="[1;31m" G="[1;32m" Y="[1;33m" C="[1;36m" B="[1;m" O="[m"
echo "$B———————————————————————————
$R TRSS$Y Yunzai$G Docker$C Script$O
    $G$NAME$C ($VERSION)$O
$B———————————————————————————
     $G作者：$C时雨🌌星空$O

$Y- 正在检查环境$O
"
DIR="${DIR:-$HOME/TRSS_Yunzai}"
CMD="${CMD:-tsyz}"
CMDPATH="${CMDPATH:-/usr/local/bin}"
DKNAME="${DKNAME:-TRSS_Yunzai}"
DKURL="${DKURL:-mirror.baidubce.com}"
abort(){ echo "
$R! $@$O";exit 1;}
mktmp(){ TMP="$DIR/tmp"&&rm -rf "$TMP"&&mkdir -p "$TMP"||abort "缓存目录创建失败";}
if type docker;then
  echo "
$G- Docker 已安装$O
"
elif type pacman &>/dev/null;then
  echo "
$Y- 正在使用 pacman 安装 Docker$O
"
  pacman -Syu --noconfirm --needed --overwrite "*" docker||abort "Docker 安装失败"
elif type apt &>/dev/null;then
  echo "
$Y- 正在使用 apt 安装 Docker$O
"
  apt update&&apt install -y docker.io||abort "Docker 安装失败"
else
  echo "
$Y- 正在使用 官方脚本 安装 Docker$O
"
  DOWNLOAD_URL="https://mirrors.ustc.edu.cn/docker-ce" bash <(curl -L get.docker.com)||abort "官方脚本 执行失败，请自行安装 Docker 后重试：https://docker.com"
fi
docker info||{ systemctl enable --now docker||service docker start&&docker info;}&&echo "
$G- Docker 已启动$O"||abort "Docker 启动失败"
abort_update(){ echo "
$R! $@$O";[ "$N" -lt 10 ]&&{ ((N++));download;}||abort "脚本下载失败，请检查网络，并尝试重新下载";}
download(){ case "$N" in
  2)Server="GitHub" URL="https://github.com/TimeRainStarSky/TRSS_Yunzai/raw/main";;
  1)Server="Gitee" URL="https://gitee.com/TimeRainStarSky/TRSS_Yunzai/raw/main";;
  3)Server="Agit" URL="https://agit.ai/TimeRainStarSky/TRSS_Yunzai/raw/branch/main";;
  4)Server="Coding" URL="https://trss.coding.net/p/TRSS/d/Yunzai/git/raw/main";;
  5)Server="GitLab" URL="https://gitlab.com/TimeRainStarSky/TRSS_Yunzai/raw/main";;
  6)Server="GitCode" URL="https://gitcode.net/TimeRainStarSky1/TRSS_Yunzai/raw/main";;
  7)Server="GitLink" URL="https://gitlink.org.cn/api/TimeRainStarSky/TRSS_Yunzai/raw?ref=main&filepath=";;
  8)Server="JiHuLab" URL="https://jihulab.com/TimeRainStarSky/TRSS_Yunzai/raw/main";;
  9)Server="Jsdelivr" URL="https://cdn.jsdelivr.net/gh/TimeRainStarSky/TRSS_Yunzai@main";;
  10)Server="Bitbucket" URL="https://bitbucket.org/TimeRainStarSky/TRSS_Yunzai/raw/main"
esac
echo "
  正在从 $Server 服务器 下载版本信息"
GETVER="$(geturl "$URL/version")"||abort_update "下载失败"
NEWVER="$(sed -n s/^version=//p<<<"$GETVER")"
NEWNAME="$(sed -n s/^name=//p<<<"$GETVER")"
NEWMD5="$(sed -n s/^md5=//p<<<"$GETVER")"
[ -n "$NEWVER" ]&&[ -n "$NEWNAME" ]&&[ -n "$NEWMD5" ]||abort_update "下载文件版本信息缺失"
echo "
$B  最新版本：$G$NEWNAME$C ($NEWVER)$O

  开始下载"
mkdir -vp "$DIR"
geturl "$URL/Main.sh">"$DIR/Main.sh"||abort_update "下载失败"
[ "$(md5sum "$DIR/Main.sh"|head -c 32)" = "$NEWMD5" ]||abort_update "下载文件校验错误"
echo "
$G- 脚本下载完成$O

$Y- 正在下载 Docker 容器$O
"
until docker pull "$DKURL/menci/archlinuxarm";do
  echo "
$R! 下载失败，5秒后重试$O
"
  sleep 5
done
echo "
$Y- 正在构建 Docker 容器$O
"
mktmp
cd "$TMP"
case "$(uname -m)" in
  aarch64|arm64|armv8*|armv9*)echo 'Server = https://mirrors.ustc.edu.cn/archlinuxarm/$arch/$repo
Server = https://mirrors.bfsu.edu.cn/archlinuxarm/$arch/$repo
Server = https://mirrors.tuna.tsinghua.edu.cn/archlinuxarm/$arch/$repo
Server = https://mirrors.aliyun.com/archlinuxarm/$arch/$repo
Server = https://mirrors.163.com/archlinuxarm/$arch/$repo
Server = https://mirrors.tencent.com/archlinuxarm/$arch/$repo
Server = https://mirror.archlinuxarm.org/$arch/$repo'>mirrorlist;echo '[options]
Architecture = aarch64'>pacman.conf;;
  *)echo 'Server = https://mirrors.ustc.edu.cn/archlinux/$repo/os/$arch
Server = https://mirrors.bfsu.edu.cn/archlinux/$repo/os/$arch
Server = https://mirrors.tuna.tsinghua.edu.cn/archlinux/$repo/os/$arch
Server = https://mirrors.aliyun.com/archlinux/$repo/os/$arch
Server = https://mirrors.163.com/archlinux/$repo/os/$arch
Server = https://mirrors.tencent.com/archlinux/$repo/os/$arch'>mirrorlist;echo '[options]
Architecture = auto'>pacman.conf
esac
echo 'Color
ParallelDownloads = 5
SigLevel = Never
[core]
Include = /etc/pacman.d/mirrorlist
[extra]
Include = /etc/pacman.d/mirrorlist
[community]
Include = /etc/pacman.d/mirrorlist
[archlinuxcn]
Server = https://mirrors.ustc.edu.cn/archlinuxcn/$arch
Server = https://mirrors.bfsu.edu.cn/archlinuxcn/$arch
Server = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch
Server = https://mirrors.aliyun.com/archlinuxcn/$arch
Server = https://mirrors.163.com/archlinux-cn/$arch
Server = https://mirrors.tencent.com/archlinuxcn/$arch
Server = https://repo.archlinuxcn.org/$arch
[arch4edu]
Server = https://mirrors.bfsu.edu.cn/arch4edu/$arch
Server = https://mirrors.tuna.tsinghua.edu.cn/arch4edu/$arch
Server = https://mirrors.aliyun.com/arch4edu/$arch
Server = https://mirrors.tencent.com/arch4edu/$arch'>>pacman.conf
echo "FROM $DKURL"'/menci/archlinuxarm
ENV LANG=zh_CN.UTF-8 TERM=xterm-256color
COPY mirrorlist /etc/pacman.d
COPY pacman.conf /etc
RUN ln -vsf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime\
 && echo "LANG=zh_CN.UTF-8">/etc/locale.conf\
 && echo "zh_CN.UTF-8 UTF-8">/etc/locale.gen\
 && locale-gen\
 && pacman -Syu --noconfirm --needed --overwrite "*" curl dialog git tmux tmate perl micro ranger fastfetch unzip fish btop htop nethogs ncdu ripgrep fd fzf bat catimg proxychains-ng ffmpeg python-poetry noto-fonts-emoji alsa-lib at-spi2-core cairo libcups dbus libdrm mesa glib2 nspr nss pango wayland libx11 libxcb libxcomposite libxdamage libxext libxfixes libxkbcommon libxrandr\
 && rm -rf /var/cache
RUN pacman -Syu --noconfirm --needed --overwrite "*" nodejs pnpm redis chromium --assume-installed adobe-source-code-pro-fonts --assume-installed cantarell-fonts --assume-installed ttf-liberation\
 && rm -rf /var/cache
RUN echo -n '\''exec bash /root/TRSS_Yunzai/Main.sh "$@"'\''>/usr/local/bin/tsyz\
 && chmod 755 /usr/local/bin/tsyz
WORKDIR /root/TRSS_Yunzai'>Dockerfile
docker build -t trss:yunzai .||abort "Docker 容器构建失败"
echo "
$Y- 正在启动 Docker 容器$O
"
docker rm -f $DKNAME 2>/dev/null
docker image prune -f
docker run -itd -h TRSS-Yunzai --name $DKNAME -v "$DIR":/root/TRSS_Yunzai --restart always $([ $DKNAME = TRSS_Yunzai ]&&echo "-p 50831:50831 -p 54980:54980"||echo "-p 50831 -p 54980") trss:yunzai||abort "Docker 容器启动失败"
mkdir -vp "$CMDPATH"&&
echo -n "exec docker exec -it $DKNAME bash Main.sh "'"$@"'>"$CMDPATH/$CMD"&&
chmod 755 "$CMDPATH/$CMD"||abort "脚本执行命令 $CMDPATH/$CMD 设置失败，手动执行命令：docker exec -it $DKNAME bash Main.sh"
echo "
$G- Docker 容器安装完成，启动命令：$C$CMD$O";exit;}
echo "
$Y- 正在下载脚本$O"
geturl(){ curl -L --retry 2 --connect-timeout 5 "$@";}
N=1
download