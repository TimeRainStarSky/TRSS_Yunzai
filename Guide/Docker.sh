#TRSS Yunzai Docker 安装脚本 作者：时雨🌌星空
NAME=v1.0.0;VERSION=202209280
R="[1;31m";G="[1;32m";Y="[1;33m";C="[1;36m";B="[1;m";O="[m"
echo "$B———————————————————————————
$R TRSS$Y Yunzai$G Docker$C Script$O
    $G$NAME$C ($VERSION)$O
$B———————————————————————————
     ${G}作者：${C}时雨🌌星空$O"
DIR="$HOME/TRSS_Yunzai"
abort(){ echo "
$R! $@$O";exit 1;}
mktmp(){ TMP="$DIR/tmp"&&rm -rf "$TMP"&&mkdir -p "$TMP"||abort "创建缓存文件夹失败";}
if which docker &>/dev/null;then
  echo "
$G- Docker 已安装$O"
elif which pacman &>/dev/null;then
  echo "
$Y- 正在使用 pacman 安装 Docker$O
"
  pacman -Syu --noconfirm --needed --overwrite "*" docker||abort "Docker 安装失败"
elif which apt &>/dev/null;then
  echo "
$Y- 正在使用 apt 安装 Docker$O
"
  apt update&&apt install -y docker.io||abort "Docker 安装失败"
else abort "请先安装 Docker"
fi
abort_update(){ echo "
$R! $@$O";[ "$N" -lt 10 ]&&{ let N++;download;}||abort "脚本下载失败，请检查网络，并尝试重新下载";}
download(){ case "$N" in
  2)SERVER="GitHub";URL="https://github.com/TimeRainStarSky/TRSS_Yunzai/raw/main";;
  1)SERVER="Gitee";URL="https://gitee.com/TimeRainStarSky/TRSS_Yunzai/raw/main";;
  3)SERVER="Agit";URL="https://agit.ai/TimeRainStarSky/TRSS_Yunzai/raw/branch/main";;
  4)SERVER="GitLab";URL="https://gitlab.com/TimeRainStarSky/TRSS_Yunzai/raw/main";;
  5)SERVER="Coding";URL="https://trss.coding.net/p/TRSS/d/Yunzai/git/raw/main";;
  6)SERVER="Aliyun";URL="https://code.aliyun.com/TimeRainStarSky/TRSS_Yunzai/raw/main";;
  7)SERVER="GitCode";URL="https://gitcode.net/TimeRainStarSky1/TRSS_Yunzai/raw/main";;
  8)SERVER="JiHuLab";URL="https://jihulab.com/TimeRainStarSky/TRSS_Yunzai/raw/main";;
  9)SERVER="Bitbucket";URL="https://bitbucket.org/TimeRainStarSky/TRSS_Yunzai/raw/main";;
  10)SERVER="Jsdelivr";URL="https://cdn.jsdelivr.net/gh/TimeRainStarSky/TRSS_Yunzai@main"
esac
echo "
  正在从 $SERVER 服务器 下载版本信息"
GETVER="$(geturl "$URL/version")"||abort_update "下载失败"
NEWVER="$(echo -n "$GETVER"|sed -n s/^version=//p)"
NEWNAME="$(echo -n "$GETVER"|sed -n s/^name=//p)";MD5="$(echo -n "$GETVER"|sed -n s/^md5=//p)"
[ -n "$NEWVER" ]&&[ -n "$NEWNAME" ]&&[ -n "$MD5" ]||abort_update "下载文件版本信息缺失"
echo "
$B  最新版本：$G$NEWNAME$C ($NEWVER)$O

  开始下载"
mkdir -vp "$DIR"
geturl "$URL/Main.sh">"$DIR/Main.sh"||abort_update "下载失败"
[ "$(md5sum "$DIR/Main.sh"|head -c 32)" = "$MD5" ]||abort_update "下载文件校验错误"
echo "
$G- 脚本下载完成$O";}
echo "
$Y- 正在下载脚本$O";geturl(){ curl -L --retry 2 --connect-timeout 5 "$@";};N=1;download
echo "
$Y- 正在构建 Docker 容器$O
"
mktmp&&cd "$TMP"
echo 'Server = https://mirrors.tuna.tsinghua.edu.cn/archlinux/$repo/os/$arch
Server = https://mirrors.ustc.edu.cn/archlinux/$repo/os/$arch
Server = https://mirrors.bfsu.edu.cn/archlinux/$repo/os/$arch
Server = https://mirrors.aliyun.com/archlinux/$repo/os/$arch'>mirrorlist
echo '[options]
Architecture = auto
Color
ParallelDownloads = 5
[core]
Include = /etc/pacman.d/mirrorlist
[extra]
Include = /etc/pacman.d/mirrorlist
[community]
Include = /etc/pacman.d/mirrorlist
[archlinuxcn]
Server = https://mirrors.bfsu.edu.cn/archlinuxcn/$arch
Server = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch
Server = https://repo.archlinuxcn.org/$arch
SigLevel = Never'>pacman.conf
echo 'comment_char %
escape_char /

% This file is part of the GNU C Library and contains locale data.
% The Free Software Foundation does not claim any copyright interest
% in the locale data contained in this file.  The foregoing does not
% affect the license of the GNU C Library as a whole.  It does not
% exempt you from the conditions of the license if your use would
% otherwise be governed by that license.

% Chinese language locale for the Peoples Republic of China
%
% This work is based on ISO PDTR 14652, Unicode 3.0, locale definition
% file for zh_CN revision 1.0 (hashao@china.com, 1999-04-28) and
% charmap file for GBK version 1.0 (sean.chen@turbolinux.com).
%
% The file is designed to work with multiple charsets.  To ease the
% maintance and adding support for new charsets, all characters are
% in UCS notation and presented in Unicode order.
%
% Changelog:
% Tue Jul 25 2000 Yong Li <rigel863@hotmail.com>
% - first version for glibc 2.2

LC_IDENTIFICATION
title      "Chinese locale for Peoples Republic of China"
source     ""
address    ""
contact    ""
email      "bug-glibc-locales@gnu.org"
tel        ""
fax        ""
language   "Chinese"
territory  "China"
revision   "0.1"
date       "2000-07-25"

category "i18n:2012";LC_IDENTIFICATION
category "i18n:2012";LC_CTYPE
category "i18n:2012";LC_COLLATE
category "i18n:2012";LC_TIME
category "i18n:2012";LC_NUMERIC
category "i18n:2012";LC_MONETARY
category "i18n:2012";LC_MESSAGES
category "i18n:2012";LC_PAPER
category "i18n:2012";LC_NAME
category "i18n:2012";LC_ADDRESS
category "i18n:2012";LC_TELEPHONE
category "i18n:2012";LC_MEASUREMENT
END LC_IDENTIFICATION


LC_CTYPE
% This is a copy of the "i18n" LC_CTYPE with the following modifications:
% - Additional classes: hanzi

copy "i18n"

translit_start
include  "translit_combining";""
translit_end

class	"hanzi"; /
%	<U3400>..<U4DBF>;/
	<U4E00>..<U9FA5>;/
	<UF92C>;<UF979>;<UF995>;<UF9E7>;<UF9F1>;<UFA0C>;<UFA0D>;<UFA0E>;/
	<UFA0F>;<UFA11>;<UFA13>;<UFA14>;<UFA18>;<UFA1F>;<UFA20>;<UFA21>;/
	<UFA23>;<UFA24>;<UFA27>;<UFA28>;<UFA29>
END LC_CTYPE

% ISO 14651 collation sequence
LC_COLLATE
copy "iso14651_t1_pinyin"
END LC_COLLATE


LC_MONETARY
int_curr_symbol           "CNY "
currency_symbol           "<UFFE5>"
mon_decimal_point         "."
mon_thousands_sep         ","
mon_grouping              3
positive_sign             ""
negative_sign             "-"
int_frac_digits           2
frac_digits               2
p_cs_precedes             1
p_sep_by_space            0
n_cs_precedes             1
n_sep_by_space            0
int_p_cs_precedes         1
int_p_sep_by_space        0
int_n_cs_precedes         1
int_n_sep_by_space        0
p_sign_posn               4
n_sign_posn               4
int_p_sign_posn           1
int_n_sign_posn           1
END LC_MONETARY

LC_NUMERIC
decimal_point             "."
thousands_sep             ","
grouping                  3
END LC_NUMERIC

LC_TIME
abday 	"<U65E5>";"<U4E00>";"<U4E8C>";"<U4E09>";"<U56DB>";"<U4E94>";"<U516D>"

day 	"<U661F><U671F><U65E5>";/
	"<U661F><U671F><U4E00>";/
	"<U661F><U671F><U4E8C>";/
	"<U661F><U671F><U4E09>";/
	"<U661F><U671F><U56DB>";/
	"<U661F><U671F><U4E94>";/
	"<U661F><U671F><U516D>"

abmon	"1<U6708>";"2<U6708>";/
	"3<U6708>";"4<U6708>";/
	"5<U6708>";"6<U6708>";/
	"7<U6708>";"8<U6708>";/
	"9<U6708>";"10<U6708>";/
	"11<U6708>";"12<U6708>"

mon	"<U4E00><U6708>";"<U4E8C><U6708>";"<U4E09><U6708>";/
	"<U56DB><U6708>";"<U4E94><U6708>";"<U516D><U6708>";/
	"<U4E03><U6708>";"<U516B><U6708>";"<U4E5D><U6708>";/
	"<U5341><U6708>";"<U5341><U4E00><U6708>";"<U5341><U4E8C><U6708>"

d_t_fmt "%Y<U5E74>%m<U6708>%d<U65E5> %A %H<U65F6>%M<U5206>%S<U79D2>"

d_fmt   "%Y<U5E74>%m<U6708>%d<U65E5>"

t_fmt   "%H<U65F6>%M<U5206>%S<U79D2>"

am_pm   "<U4E0A><U5348>";"<U4E0B><U5348>"

t_fmt_ampm "%p %I<U65F6>%M<U5206>%S<U79D2>"

date_fmt       "%Y<U5E74> %m<U6708> %d<U65E5> %A %H:%M:%S %Z"
week 7;19971130;1
first_weekday 2
END LC_TIME

LC_MESSAGES
yesexpr "^[+1yY<UFF59><UFF39><U662F>]"
noexpr  "^[-0nN<UFF4E><UFF2E><U4E0D><U5426>]"
yesstr  "<U662F>"
nostr   "<U4E0D><U662F>"
END LC_MESSAGES

LC_PAPER
copy "i18n"
END LC_PAPER

LC_TELEPHONE
tel_int_fmt	"+%c %a %l"
tel_dom_fmt	"0%a %l"
int_select	"00"
int_prefix	"86"
END LC_TELEPHONE

LC_NAME
name_fmt	"%f%t%g%t%d"
name_gen	""
name_miss	"<U5C0F><U59D0>"
name_mr		"<U5148><U751F>"
name_mrs	"<U592A><U592A>"
name_ms		"<U5973><U58EB>"
END LC_NAME

LC_ADDRESS
postal_fmt	"%c%N%T%N%s %h %e %r%N%b%N%d%N%f%N%a%N"
country_name	"<U4E2D><U534E><U4EBA><U6C11><U5171><U548C><U56FD>"
%country_post	"FIXME"
country_ab2	"CN"
country_ab3	"CHN"
country_num	156
country_car "CHN"
country_isbn	7
lang_name	"<U4E2D><U6587>"
lang_ab		"zh"
lang_term	"zho"
lang_lib	"chi"
END LC_ADDRESS

LC_MEASUREMENT
copy "i18n"
END LC_MEASUREMENT'>zh_CN
echo -n "bash '$DIR/Main.sh' "'"$@"'>tsyz
echo 'FROM hub-mirror.c.163.com/library/archlinux
COPY mirrorlist /etc/pacman.d
COPY pacman.conf /etc
COPY zh_CN /usr/share/i18n/locales
RUN pacman -Syy --noconfirm --needed --overwrite "*" archlinux-keyring archlinuxcn-keyring &&\
    pacman -Syu --noconfirm --needed --overwrite "*" curl git libnewt micro neofetch perl ranger tmux chromium ffmpeg python-poetry &&\
    sed -i "s/#.*zh_CN\.UTF-8 UTF-8/zh_CN.UTF-8 UTF-8/g" /etc/locale.gen &&\
    locale-gen &&\
    rm -rf /var/cache
COPY tsyz /bin
RUN chmod 755 /bin/tsyz'>Dockerfile
docker build -t trss:yunzai .||abort "Docker 容器构建失败"
docker image prune -f
echo "
$Y- 正在启动 Docker 容器$O
"
docker run -itPd --name TRSS_Yunzai -v "$DIR":/root/TRSS_Yunzai --restart=always trss:yunzai||abort "Docker 容器启动失败，若要重装容器，请先停止并删除已安装容器"
echo -n "docker exec -it TRSS_Yunzai bash '/root/TRSS_Yunzai/Main.sh' "'"$@"'>/bin/tsyz||abort "脚本执行命令/bin/tsyz设置失败"
chmod 755 /bin/tsyz||abort "脚本权限设置失败"
echo "
$G- Docker 容器安装完成，输入tsyz执行$O"