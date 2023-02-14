#TRSS Yunzai MSYS2 安装脚本 作者：时雨🌌星空
NAME=v1.0.0;VERSION=202302145
R="[1;31m" G="[1;32m" Y="[1;33m" C="[1;36m" B="[1;m" O="[m"
echo "$B————————————————————————————
$R TRSS$Y Yunzai$G Install$C Script$O
     $G$NAME$C ($VERSION)$O
$B————————————————————————————
      $G作者：$C时雨🌌星空$O"
abort(){ echo "
$R! $@$O";exit 1;}
export LANG=zh_CN.UTF-8 MSYS=winsymlinks USERPROFILE="$(cygpath -w "$HOME")"
export APPDATA="$USERPROFILE\\AppData\\Roaming" LOCALAPPDATA="$USERPROFILE\\AppData\\Local"
DIR="${DIR:-$HOME/TRSS_Yunzai}"
CMD="${CMD:-tsyz}"
CMDPATH="${CMDPATH:-/usr/local/bin}"

type pacman &>/dev/null||abort "找不到 pacman 命令，请确认安装了正确的 MSYS2 环境"
type curl dialog unzip git &>/dev/null||{ echo "
$Y- 正在安装依赖$O
"
pacman -Syu --noconfirm --needed --overwrite "*" curl dialog unzip git||abort "依赖安装失败";}

mktmp(){ TMP="$DIR/tmp"&&rm -rf "$TMP"&&mkdir -p "$TMP"||abort "缓存目录创建失败";}
geturl(){ curl -L --retry 2 --connect-timeout 5 "$@";}
mkcmd(){ ln -vsf "$2" "/usr/bin/$1"&&
echo -n "@echo off
\"$(cygpath -w "$2")\" %*">"/usr/bin/$1.cmd";}
git_clone(){ git clone --depth 1 --single-branch "$@";}

type ffmpeg &>/dev/null||{ echo "
$Y- 正在安装 FFmpeg$O
"
mktmp
rm -rf /win/ffmpeg&&
mkdir -vp /win&&
git_clone "https://gitee.com/TimeRainStarSky/ffmpeg-windows" /win/ffmpeg||abort "下载失败"
mkcmd ffmpeg /win/ffmpeg/bin/ffmpeg&&
mkcmd ffplay /win/ffmpeg/bin/ffplay&&
mkcmd ffprobe /win/ffmpeg/bin/ffprobe||abort "安装失败";}

type redis-server redis-cli &>/dev/null||{ echo "
$Y- 正在安装 Redis$O
"
mktmp
rm -rf /win/redis&&
git_clone "https://gitee.com/TimeRainStarSky/redis-windows" /win/redis||abort "下载失败"
mkcmd redis-cli /win/redis/redis-cli&&
mkcmd redis-server /win/redis/redis-server||abort "安装失败";}

type node &>/dev/null||{ echo "
$Y- 正在安装 Node.js$O
"
mktmp
GETVER="$(geturl "https://registry.npmmirror.com/-/binary/node/index.tab"|sed -n 2p|cut -f1)"&&
geturl "https://registry.npmmirror.com/-/binary/node/$GETVER/node-$GETVER-win-x64.zip">"$TMP/node.zip"||abort "下载失败"
unzip -oq "$TMP/node.zip" -d "$TMP"||abort "解压失败"
rm -rf /win/node&&
mv -vf "$TMP/"*/ /win/node&&
mkcmd node /win/node/node||abort "安装失败";}

type pnpm &>/dev/null||{ echo "
$Y- 正在安装 pnpm$O
"
mktmp
GETVER="$(geturl "https://registry.npmmirror.com/pnpm/latest"|sed 's/.*"version":"//;s/",.*//')"&&
geturl "https://registry.npmmirror.com/pnpm/-/pnpm-$GETVER.tgz">"$TMP/pnpm.tgz"||abort "下载失败"
tar -xzf "$TMP/pnpm.tgz" -C "$TMP"||abort "解压失败"
mkdir -vp /usr/lib/node_modules&&
mv -vf "$TMP/package" /usr/lib/node_modules/pnpm&&
echo -n 'exec /usr/lib/node_modules/pnpm/bin/pnpm.cjs "$@"'>/usr/bin/pnpm&&
echo -n 'exec /usr/lib/node_modules/pnpm/bin/pnpx.cjs "$@"'>/usr/bin/pnpx&&
echo -n "@echo off
node \"$(cygpath -w /usr/lib/node_modules/pnpm/bin/pnpm.cjs)\" %*">/usr/bin/pnpm.cmd&&
echo -n "@echo off
node \"$(cygpath -w /usr/lib/node_modules/pnpm/bin/pnpx.cjs)\" %*">/usr/bin/pnpx.cmd||abort "安装失败";}

type python &>/dev/null||{ GETVER="3.10.9"
echo "
$Y- 正在安装 Python $GETVER$O
"
mktmp
geturl "https://registry.npmmirror.com/-/binary/python/$GETVER/python-$GETVER-embed-amd64.zip">"$TMP/python.zip"||abort "下载失败"
rm -rf /win/python&&
mkdir -vp /win/python/Lib&&
unzip -oq "$TMP/python.zip" -d /win/python&&
unzip -oq /win/python/*.zip -d /win/python/Lib&&
rm -rf /win/python/*.zip /win/python/*._pth||abort "解压失败"
echo -n "import sys
import io
sys.stdin=io.TextIOWrapper(sys.stdin.buffer,encoding='utf8')
sys.stdout=io.TextIOWrapper(sys.stdout.buffer,encoding='utf8')
sys.stderr=io.TextIOWrapper(sys.stderr.buffer,encoding='utf8')">/win/python/sitecustomize.py&&
mkcmd python /win/python/python||abort "安装失败";}

type pip &>/dev/null||{ echo "
$Y- 正在安装 pip$O
"
mktmp
git_clone "https://gitee.com/TimeRainStarSky/pip" "$TMP"||abort "下载失败"
python "$TMP/pip.pyz" install -i "https://mirrors.bfsu.edu.cn/pypi/web/simple" -U pip&&
mkcmd pip /win/python/Scripts/pip||abort "安装失败";}

type poetry &>/dev/null||{ echo "
$Y- 正在安装 Poetry$O
"
pip install -i "https://mirrors.bfsu.edu.cn/pypi/web/simple" -U poetry&&
mkcmd poetry /win/python/Scripts/poetry||abort "安装失败";}

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
N=1
download