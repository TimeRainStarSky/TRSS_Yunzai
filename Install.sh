#TRSS Yunzai 安装脚本 作者：时雨🌌星空
NAME=v1.0.0;VERSION=202303030
R="[1;31m" G="[1;32m" Y="[1;33m" C="[1;36m" B="[1;m" O="[m"
echo "$B————————————————————————————
$R TRSS$Y Yunzai$G Install$C Script$O
     $G$NAME$C ($VERSION)$O
$B————————————————————————————
      $G作者：$C时雨🌌星空$O"
abort(){ echo "
$R! $@$O";exit 1;}
export LANG=zh_CN.UTF-8
DIR="${DIR:-$HOME/TRSS_Yunzai}"
CMD="${CMD:-tsyz}"
CMDPATH="${CMDPATH:-/usr/local/bin}"
type locale-gen &>/dev/null&&{ echo "
$Y- 正在设置语言$O
"
echo "LANG=zh_CN.UTF-8">/etc/locale.conf&&
sed -i 's/#.*zh_CN\.UTF-8 UTF-8/zh_CN.UTF-8 UTF-8/g' /etc/locale.gen&&
locale-gen||echo "
$R! 语言设置失败$O";}
type pacman &>/dev/null||abort "找不到 pacman 命令，请确认安装了正确的 Arch Linux 环境"
type curl dialog &>/dev/null||{ echo "
$Y- 正在安装依赖$O
"
pacman -Syu --noconfirm --needed --overwrite "*" curl dialog||abort "依赖安装失败";}
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
[ "$(md5sum "$DIR/Main.sh"|head -c 32)" != "$NEWMD5" ]&&abort_update "下载文件校验错误"
mkdir -vp "$CMDPATH"&&echo -n "exec bash '$DIR/Main.sh' "'"$@"'>"$CMDPATH/$CMD"&&chmod 755 "$CMDPATH/$CMD"||abort "脚本执行命令 $CMDPATH/$CMD 设置失败，手动执行命令：bash '$DIR/Main.sh'"
echo "
$G- 脚本安装完成，启动命令：$C$CMD$O";exit;}
echo "
$Y- 正在下载脚本$O"
geturl(){ curl -L --retry 2 --connect-timeout 5 "$@";}
N=1
download