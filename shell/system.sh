#!/usr/bin/env bash

# cpu
ps aux | head -1; ps aux | sort -nrk 3 | head -5

# mem
ps aux | head -1; ps aux | sort -nrk 4 | head -5

cat /proc/meminfo | grep MemTotal
free -k
free -m

#CPU 型号
cat /proc/cpuinfo  |grep name | cut -d: -f2 | uniq -c
#物理CPU 数
cat /proc/cpuinfo | grep "physical id" | wc -l
#查看单个物理CPU core数
cat /proc/cpuinfo  | grep cores | uniq
#查看逻辑CPU数
cat /proc/cpuinfo  | grep processor | wc -l

#IO 磁盘 IO 和 网络IO

# CPU MEM IO 磁盘瓶颈
sar -d -p 1 2

top
1
c

# 网络
 ethtool ethN
 ethtool -s eth0 autoneg off duplex full
 ifconfig eth1
 route -n
 nslookup baidu.com
 /etc/resolv.conf nameserver 10.21.1.205
 traceroute www.baidu.com
 telnet 220.181.111.188 80
 nmap -p 22 220.181.111.188
 netstat -lnp | grep PORT

# 常见排查命令
 cat  /var/log/messages  | grep PID
 ps aux|head -1;ps aux|grep -v PID|sort -rn -k +3|head
 uptime
 W
 dmesg | more
 dmesg | tail
 vmstat 1 5 #5次/sort
    r : 等待CPU PID 数；应小于 CPU core 数
	free: free memory 单位 K
	si,so 交换分区 写入 和 读取 的量，当值不等于0，物理内存已不足
	us,sy,id,wa,st: CPU 消耗时间 wa,st: IO 等待时间和被偷走时间
 mpstat -P ALL 1 CPU 个数和占用
 pidstat 1 #PID CPU 占用
 iostat -zx 1 #磁盘
 sar -n DEV 1 #网络
 sar -n TCP,ETCP 1

 # 普通 用户 提权
useradd $add_new_username
echo $add_new_user_password |passwd --stdin $add_new_username
chmod  0640 /etc/sudoers
{{ add_new_username }} ALL=(ALL) NOPASSWD: ALL
chmod  0440 /etc/sudoers

# 查看 进程 端口
netstat -antlp | grep `ps aux | grep http | grep -v "\--color"| awk '{print $2}'`

# 域名
/etc/resolv.conf文件
nameserver 8.8.8.8

# selinux firewalld
/etc/selinux/config
systemctl disable firewalld

# 免密登录
ssh-keygen -t rsa
ssh-copy-id -i ~/.ssh/id_rsa.pub root@host

# 替换 换行 空格
echo char | tr '\n' ' ' | sed 's/ //g'"

# yum执行报错No module named yummain处理
wget  http://yum.baseurl.org/download/3.4/yum-3.4.0.tar.gz
tar -xf yum-3.4.0.tar.gz
cd yum-3.4.0
./yummain.py  install yum
yum update

# rpm 包下载
http://rpm.pbone.net/

# ssh 修复
rpm -qa openssh*
yum remove openssh

yum install openssh openssh-server openssh-clients

chmod -R 777 /etc/polkit-1/rules.d
yum search polkit
yum -y install polkit.x86_64

systemctl restart  polkit.service
service sshd start
echo root:12345678  | chpasswd

# 大文件处理
https://www.cnblogs.com/cherishui/p/4136847.html

wget http://ftp.gnu.org/gnu/parallel/parallel-latest.tar.bz2
 tar -xf parallel-latest.tar.bz2
 cd parallel-20191022/
./configure
  make
make install

cat 11 | parallel   --pipe sed 's?\`??g' >> 22

# securecrt SFTP
alt+p
put:
cd [dit]
lcd [dir]
put filename

get
...
get filename

#
$* 参数
$$
Shell本身的PID（ProcessID）
$!
Shell最后运行的后台Process的PID
$?
最后运行的命令的结束代码（返回值）
$*
所有参数列表。如"$*"用「"」括起来的情况、以"$1 $2 … $n"的形式输出所有参数。
$@
所有参数列表。如"$@"用「"」括起来的情况、以"$1" "$2" … "$n" 的形式输出所有参数。
$#
添加到Shell的参数个数
$0
Shell本身的文件名
$1～$n
添加到Shell的各参数值。$1是第1参数、$2是第2参数…

#字符串分割
awk -F "符号" ‘{print $1"想追加的字符"}’
#打印第N列后的所有列（不包括第N列）
awk '{for(i=N+1;i<=NF;i++)printf $i "  ";printf"\n"}' file

查看文件内容
cat -s file
#将多个空行转换为一行
cat file | tr -s '\n'
不显示空白行

#复制子文件及其属性
cp -rp

#if 匹配
[[ $port =~ ^[0-9]{1,5}$ ]]
$i =~ ^[0-9]+$

[[ ]] 是if判断使用正则表达式的固定格式
=~表示匹配
^ 是以什么开头
+ 表示1到多个
$ 是以什么结尾

#if 判断
BB=
[[ -n $BB ]]   #“-n”为空
[root]# echo $?

#a=2
if [ $a ];then
echo ok
fi
如果a有值,输出OK

#jq 对JSON进行操作

ln -s 【目标目录】 【软链接地址】
!!!创建符号链接的时候一定要使用绝对路径 ，否则会出现“符号连接的层数过多”，是由于不同路径访问都采用了相对路径

rm -rf 【软链接地址】
上述指令中，软链接地址最后不能含有“/”，当含有“/”时，删除的是软链接目标目录下的资源，而不是软链接本身。

ln -snf 【新目标目录】 【软链接地址】
这里修改是指修改软链接的目标目录

#readlink  追溯源文件

#########
#basename 去除绝对路径

变量和字符一起组合
echo ${a}s

a=`echo 'ls /homewew"m'`
echo $a  | sed 's/"/\\\\"/g'`
#将字符串   ls /homewew"m'  中的“ 替换为\\"

# 指定行替换整行：
sed '行号c 新的内容' 要处理的文件
sed -e "/url/c${url}" file

# 指定替换某个字符：
sed -i "s/account/${app}/g" file

a=aaaaa
echo ${a//bbb-/}

删除指定行后的文件：
cat a | sed -e '/auto/,$d'

在指定行后添加多行文本：
      将多行文本存到指定文件
      sed -e '/指定行字符/r 指定的多行文本文件' 需要修改的文件

#替换时附加引号
sed -e "s/${aa}/\"${aa1}\"/g" aa

#将/ 替换成 \/
GitUrl="$( echo "${GitUrl}" | sed 's/\//\\\//g' )"

#屏蔽输入输出，多用于密码字段
stty -echo

#date 格式
输出30天前的日期：
date -d '30 days ago' +%F
date=`date -d "$one_month_ago" +%s`
#将“年-月-日”日期格式转换为秒格式
date "+%Y-%m-%d %H:%M:%S"
ts=`date +%Y%m%d%H%M%S` ###20190304235406

#匹配以字符#开头
if [[ "$a" =~ ^#  ]];then
   echo 1
fi
#########################
#匹配以字符fd结尾
if [[ "$a" =~ fd$  ]];then
   echo 1
fi

文本统计：wc (word count)
      -l：多少行
      -w：多少单词
      -c：多少字符
      -L：最长的一行包含了多少个字符

######## 断电
ERROR:/dev/sda2: Inodes that were part of a corrupted orphan linked list found.
fsck.ext4 /dev/sda2
fsck.ext4 -y /dev/sda2

############ /var/log 系统日志 系统信息
Linux /var/log下的各种日志文件详解

系统的引导日志:/var/log/boot.log
系统日志一般都存在/var/log下
核心启动日志:/var/log/dmesg
系统报错日志:/var/log/messages
邮件系统日志:/var/log/maillog
FTP系统日志:/var/log/xferlog
安全信息和系统登录与网络连接的信息:/var/log/secure
登录记录:/var/log/wtmp      记录登录者讯录，二进制文件，须用last来读取内容    who -u /var/log/wtmp 查看信息
News日志:/var/log/spooler
RPM软件包:/var/log/rpmpkgs
XFree86日志:/var/log/XFree86.0.log
引导日志:/var/log/boot.log   记录开机启动信息，dmesg | more
cron(定制任务日志)日志:/var/log/cron
安全信息和系统登录与网络连接的信息:/var/log/secure

文件 /var/run/utmp 现在登录用户
文件 /var/log/wtmp 所有登录登出
文件 /var/log/lastlog 用户最后登录信息
文件 /var/log/btmp 错误登录尝试
#相关查询登录信息命令： w who last
#相关开机信息命令：dmesg
#相关系统信息命令：uptime top free df fdisk cat /etc/redhat-release

############ 快速度量磁盘信息
http://soft.vpser.net/manage/ncdu/ncdu-1.6.tar.gz
./configure
make && make install
启动路径：/usr/local/bin/ncdu

提示：
configure: error: no acceptable C compiler found in $PATH
请安装gcc编译器：
#yum -y install gcc gcc-c++
configure: error: required header file not found
请安装:
yum -y install ncurses ncurses-devel

#########################

上下箭头切换目录
左右箭头切换父级目录
s 按 文件大小排序
n 按 文件名排序
q 退出


n - 按名称排序（再次按降序排列）
s - 按文件大小排序（再次按降序排列）
d - 删除所选文件或目录
g - 显示百分比和/或图表
t - 排序时在文件之前切换dirs
c - 切换子项目计数的显示
b - 当前目录中的Spawn shell
i - 显示有关所选项目的信息
r - 刷新/重新计算当前目录
q - 退出ncdu

#### clean /var/log/journal 
#journalctl --disk-usage
5 2 * * * journalctl --vacuum-time=1w

权限管理 只读账户
##########################

1
useradd yuanpengchao
echo "EA7HVQSejL7gVeBG" | passwd yuanpengchao --stdin

#setfacl -m u:yuanpengchao:r -R /data
#setfacl -x user:yuanpengchao -R /data/
#getfacl /data/

2
mkdir /home/yuanpengchao/.bin

chown root. /home/yuanpengchao/.bash_profile 
chmod 755 /home/yuanpengchao/.bash_profile

chattr -i /home/yuanpengchao/.bash_profile

vi /home/yuanpengchao/.bash_profile 

PATH=$HOME/.bin

3
ln -s /usr/bin/wc  /home/yuanpengchao/.bin/wc
ln -s /usr/bin/tail  /home/yuanpengchao/.bin/tail
ln -s /bin/more  /home/yuanpengchao/.bin/more
ln -s /bin/cat  /home/yuanpengchao/.bin/cat
ln -s /bin/grep  /home/yuanpengchao/.bin/grep
ln -s /bin/find  /home/yuanpengchao/.bin/find
ln -s /bin/pwd  /home/yuanpengchao/.bin/pwd
ln -s /bin/ls  /home/yuanpengchao/.bin/ls
ln -s /usr/bin/less /home/yuanpengchao/.bin/less
ln -s /bin/tar  /home/yuanpengchao/.bin/tar
ln -s /bin/cd  /home/yuanpengchao/.bin/cd


4
su yuanpengchao
source /home/yuanpengchao/.bash_profile 


##
#修改账户密码保留时间
# -M max -m min -W waning
chage -M 60 -m 0 -W 7 root
# m M W
cat /etc/shadow | grep root | awk -F ":" '{print $4" "$5" "$6}'
