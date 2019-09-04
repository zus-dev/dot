## Find Thigs
```bash
# By name
find /path/to/search -name filename

# By name case-insensitive
find /path/to/search -iname filename

# Only files by name 
find /path/to/search -name filename -type f

# Only directories by name
find /path/to/search -name dirname -type d

# All symlinks 
find /path/to/search -type l

# By owner 
find /path/to/search -user owner

# Executable files
find /path/to/search -type f -executable

# Things changed today                                                                                                                                                              
find /path/to/search -daystart -ctime -1

# Things changed in the last 24 hours
find /path/to/search -ctime -1

# Deleting things you find
find /path/to/search -delete

# Printing Type of file, Filename & Inode
find /path/to/search -printf "%y %i %prn"

# Finding Broken Symlinks
find /path/to/search -follow -lname "*"

# Using Regex with find
find /path/to/search -regex 'regex pattern (full path)'
find /var -regex '.*/tmp/.*[0-9]*.file'

find . -name "*storage-controller*" -type f -executable
```

## Replacing stuff
```bash
# Find all files with the specific pattern and replace stuff with sed in those files
grep mega_bytes_per_sec -r . -l | xargs sed -i 's/bandwidth_mega_bytes_per_sec_limit/bandwidth_bytes_per_sec/g'

# Find and replace
find . -type f -name 'xa*' | xargs sed -i 's/asd/dsg/g'
```


## Grep 
```bash
# grep with line numbers
grep 'DiskToAdd' -n -r . --include=*.{h,cpp}

# grep with file names only 
grep 'DiskToAdd' -n -r . --include=*.{h,cpp}

```


## Select unique or distinct values
```bash
# uniq will output all lines exactly once
# uniq -d will output all lines that appear more than once
# uniq -u will output all lines that appear exactly once
./yourscript.ksh | sort | uniq
```


## YUM 
```bash
yum group list ids
yum group install "Development Tools"

# Which package supplies a file I'm looking for?
yum whatprovides [FILE]

# Install rpm file along with its all dependencies
yum localinstall MY-RPM
yum localinstall http://pkgs.repoforge.org/subversion/subversion-devel-1.7.1-0.1.el6.rfx.i686.rpm

# error: The GPG keys listed for the repository are already installed but they are not correct for this package
yum update --nogpgcheck

# reinstall packages dependancies
rpm -Va
yum reinstall $(repoquery --requires --recursive --resolve <pkg>)

# view transaction history
yum history list

# display all transactions
yum history list all

# list files in package
repoquery -l <pkg>

# show the installation date of the package
rpm -qa --last

# clean up
yum clean all
yum-complete-transaction --cleanup-only
```


## RPM
```bash
# Extract rpm 
rpm2cpio [FILE] | cpio -idmv
```


## DEB
```bash
# Extract deb
ar vx my.deb
tar xvf control.tar.gz
tar xvf data.tar.gz

# List all installed packages
dpkg-query -l
```

## Services
### Debian 
```bash
sudo service --status-all
sudo service cloudistics-network-controller status
```

## Docker 
```bash
# Clean /var/lib/docker/overlay2 
sudo docker system prune -a -f
```

## OS version
```bash
cat /etc/os-release
lsb_release -a
uname -r
```

## GIT 
```bash
# Skip commit hooks
git commit --no-verify

# See the changes in a git commit
git diff COMMIT~ COMMIT

# get list of changed files
git diff-tree --no-commit-id --name-only -r <commit-hash>

git commit --amend --no-edit

# set or unset upstream
git branch --set-upstream-to upstream/master
git branch --unset-upstream

# Apply delete 
git rm FILE

# Recover from git reset --hard
git reflog show
# said the commit to be recovered back is on 9300f9d (with commit message fix-bug)
git reset HEAD@{7}

# Content of the most recent stash
git stash show -p

# content of an arbitrary stash
git stash show -p stash@{1}

# delete most recent stash
git stash drop

# delete arbitrary stash
git stash drop stash@{0}

# list the tags
git tag -l
# checkout and create a branch by tag
git checkout tags/<tag_name> -b <branch_name>

# find branch by commit id
git branch --contains <commit>

# commit difference, commits that branch-X has but master doesn't
git log master..branch-X

# list all commits that changed a specific file
git log --follow -- filename

# skip git commit hooks
git commit --no-verify
```

## Run command periodically
```bash
watch -n 10 script.sh

# -n  interval in seconds
# -b  creates a beep sound if the exit of the command is non-zero.
# -c  Interprets ANSI color sequences.
# -d  highlights the changes in the command output.

# watch for multiple commands
watch "du -h filename.txt && df -h"
```

## Find open ports
```bash
netstat --listen
netstat -l

# Display open ports and established TCP connections
netstat -vatn

# Display only open UDP ports
netstat -vaun

# To see FQDN (full dns hostname), remove the -n flag
netstat -vat

# Display list of open ports
lsof -i

# Display all open IPv4 network files in use by the process whose PID is 9255
lsof -i 4 -a -p 9255

# Another example
lsof -iTCP -sTCP:LISTEN
```

## Find open files
```bash
lsof
```

## History 
```bash 
# Get history without line numbers
history | cut -c 8- 
```

## Hot-keys 
```bash
Ctrl + U - clear all the current line from the end to the beginning only if the cursor is at the end of the line. ...
Ctrl + K - clear all the current line from the beginning to the end only if the cursor is at the beginning of the line. ...
Ctrl + W - clear the previous word in the current line
```

## make 
```bash
# show what make is attempting to do
make -n 

# set verbose level
make VERBOSE=1
make V=1

# cmake3 has a backward incompatibility with cmake 2.x around backslashes '\\\' it interprets them differently, so check CMakeList.txt if you see strange errors

# cmake terminal gui https://cmake.org/runningcmake/
ccmake
```

## less
```bash
# Use less instead of tail 
# In less, you can press Ctrl-C to end forward mode and scroll through the file, then press F to go back to forward mode again.
less +F filename

# case insensitive search 
# You can also type command -I while less is running. It toggles case sensitivity for searches.

# less with color
less -R

```

## misk
```bash
# list all signal codes 
kill -l

# list all errno codes error codes
cat /usr/include/asm-generic/errno-base.h

# list opened ports
sudo netstat -tulpn | grep LISTEN

# last logings 
last 
# last reboot
last | grep reboot

zgrep 
zless

# disable line folding, line wrapping
# you can pass a numeric argument to specify the number of characters, e.g. typing 4 Right scrolls to the right by 4 characters 
less -S
less --chop-long-lines

# test hard disk speed
hdparm -t /dev/sda

# file creation time and other stats 
stat <file>

# count every word in the file
cat tcom.txt | tr '[:space:]' '[\n*]' | grep -v "^\s*$" | sort | uniq -c | sort -bnr 

# output unique world in file
grep -o -E '\w+' tcom.txt | sort -u -f 
grep -o -E '\w{2,}' tcom.txt | sort -u -f 
grep -o -E '[a-zA-Z]{3,}' tcom.txt | sort -u -f 

grep -o -E '\w+' tcom.txt | sort | uniq -c | sort -bnr 
grep -o -E '[a-zA-Z]{2,}' tcom.txt | sort | uniq -c | sort -bnr | grep -v -w -i -f tcom-w.txt
grep -o -E '[a-zA-Z]{2,}' tcom.txt | sort | uniq -c | sort -bnr 

grep -v -w -i -f tcom-w.txt 


grep -o -E '[a-zA-Z]{3,}' tcom.txt | awk '{print tolower($0)}' | sort -u -f 
cat {tcom-w.txt,tcom-w.txt,tlf-w.txt} | sort -f | uniq -i -u

# Util for hardware testing within the guest
nmon

# byobu detatch session
# An alternative to Alt-F6 is Prefix-Shift-D, where Prefix is your byobu escape command (typically Ctrl-a).


# determine fs type 
df -Th
df -Th | grep "^/dev"

# more information than just disk bandwidth
dstat

# best for long running advanced IO tests
fio

# dumping a computer's DMI (some say SMBIOS ) table contents in a human-readable format
dmidecode

# iSCSI targets 
scstadmin -list_target

# allocate file 
fallocate -l 100G 100G.qcow2

# show full process tree with PID, TGID
pstree -h PID -p -g -s

# show processes or threads actually doing I/O 
iotop -u

# get minor, major device numbers 
stat /dev/mapper/DISK_6e807fd0178643cd9ef041417a8a8cbc
ls -l /dev/mapper/DISK_6e807fd0178643cd9ef041417a8a8cbc

# flush block device buffers
blockdev --flushbufs /dev/dm-1
```

## Install Samba4 in CentOS 7
```
yum install samba samba-client samba-common
cp /etc/samba/smb.conf /etc/samba/smb.conf.orig

# enable samba services to be allowed through system firewall
firewall-cmd --permanent --zone=public --add-service=samba
firewall-cmd --reload

# Anonymous File Sharing (optional)
mkdir -p /srv/samba/anonymous
chmod -R 0775 /srv/samba/anonymous
chown -R nobody:nobody /srv/samba/anonymous
# change the SELinux security context for the samba shared directory
chcon -t samba_share_t /srv/samba/anonymous

vi /etc/samba/smb.conf
...
[global]
    workgroup = WORKGROUP
    netbios name = centos
    security = user
[Anonymous]
    comment = Anonymous File Server Share
    path = /srv/samba/anonymous
    browsable =yes
    writable = yes
    guest ok = yes
    read only = no
    force user = nobody
...
testparm

# Secure File Sharing (optional)
groupadd smbgrp
usermod USERNAME -aG smbgrp
smbpasswd -a USERNAME

mkdir -p /srv/samba/secure
chmod -R 0770 /srv/samba/secure
chown -R root:smbgrp /srv/samba/secure
chcon -t samba_share_t /srv/samba/secure

vi /etc/samba/smb.conf
...
[Secure]
    comment = Secure File Server Share
    path =  /srv/samba/secure
    valid users = @smbgrp
    guest ok = no
    writable = yes
    browsable = yes
...
testparm

# enable and start samba services
systemctl enable smb.service
systemctl enable nmb.service
systemctl start smb.service
systemctl start nmb.service

systemctl restart smb.service
systemctl restart nmb.service

```

## Network IO performance test. Measurement tool for TCP/UDP bandwidth performance
No Route error: 

```
yum install iperf3

# Server Side: 
iperf -s -i 1
# then on client side run:
iperf -c <server IP> -i 1
```


```
# Check binary external dependancies (dynamic libraries)
ldd /usr/bin/cloudistics-storage-controller | grep boost 

objdump -T /usr/bin/cloudistics-storage-controller | grep asio  | less
nm -T /usr/bin/cloudistics-storage-controller | grep boost
```

## Copy with stats and progress
```
rsync --info=progress2 source dest
```

```
# Cozy
flatpak run com.github.geigi.cozy &
```

## KVM CLI 
```
# manage VMs CLI
virsh
```

## CPU affinity
```
# set CPU affinity, aka pin process to cpu
taskset 
# show CPU affinity for the process in friendly manner
taskset -cp PID
# show CPU affinity for the process as a mask
# CPUs info
lscpu
# CPUs info from file
/proc/cpuinfo
# CPUs = Threads per core X cores per socket X sockets
$ lscpu | grep -E '^Thread|^Core|^Socket|^CPU\('
# corresponds to the CPU count from lscpu
nproc --all
# of /proc/cpuinfo should match this information
grep -E 'processor|core id' /proc/cpuinfo
```

## Calculator
```
eval
# bash calculator
bc
# simple math calc
echo '1+1' | bc
echo '1+1; 2+2' | bc
echo 'scale=3; 3/2' | bc
echo 'obase=16; ibase=16; 5F72+C39B' | bc
```

## disable F keys in byobu
```
# toggle on/off the use of the F-keys inside of Byobu:
shift-F12 (in tmux)
ctrl-a-! (in screen)
```

## multipath
```
lsblk -s 
lsblk -s [DEVICE PATH]
multipath -ll
```

## gdb 
```
gcc -ggdb3
# gdb with input redirection
gdb <executable>
(gdb) run < input.txt
# CMake 
# set(CMAKE_CXX_FLAGS_DEBUG "-ggdb3 -O0" CACHE STRING "")
```

## logs with journalctl and syslog
```
journalctl --since="yesterday"
# show extra help and jump to the end
journalctl -xe
```

## bash general
```
# read value from input 
read -p "Continue? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
# calc simple expressions
expr 2 \* 2
echo "$[ 2 * 2 ]"
# PWD
~+
# OLDPWD can be used with e.g. cd
~-
# explicit var declaration
declare -i NEWVAR=10
# print value and type of the var
declare -p NEWVAR
# declare readonly var
declare -r READONLY="Some value"
readonly READONLY="Some value"
# arrays
MYARRAY=("First" "Second" "Third")
# same as echo $MYARRAY
echo ${MYARRAY[0]}
echo ${MYARRAY[N]}
echo ${MYARRAY[*]}
MYARRAY[3]="Fourth"
# commandline arguments "$@" "$#" 
for var in "$@"
do
    echo "$var"
done
# write stdin to file(s) AND stdout
grep something | tee file1 file2 > file3

# use aliases in bash script
shopt -s expand_aliases
alias TODAY="date"
A=`TODAY`


# Get the backtraces for the process
pstack
```

## Stress tests cmdutils (memory, cpu, hdd) 
```
yum install stress
```

## SCST util to manage iSCSI devices
```
scstadmin -list_device
scstadmin -list_dev_attr <device>
scstadmin -list_target
scstadmin -list_tgt_attr <target> -driver <driver>

# easy way to get current settings/state/config
scstadmin -write_config scst.conf.my 

scstadmin -force -clear_config
```

## Device mapper 
```
# dmsetup ls
[root@cloudistics-storage-d2bc4fbe0622446d930b276504a8ce7c ~]# dmsetup ls
CBS_POOL        (253:10) ====> dm-10
CBS_POOL_data   (253:9)  ====> dm-9
CBS_POOL_meta   (253:8)  ====> dm-8 etc.
DISK_483496e1280f46d182906649dfc2ca31   (253:13)
SPECIAL_METADATA_STORE_f2b53ea8f92f4c32a204283420723fe6 (253:11)
SPECIAL_TEMPLATE_STORE_47c75c0b0e3d46d3b1f29bc13dfbd8ef (253:12)

[tester@cloudistics-storage-316441dbf1c94b36beca9e62b4e950a2 ~]$ readlink -f /dev/mapper/DISK_6e807fd0178643cd9ef041417a8a8cbc 
/dev/dm-14

# iostat /dev/mapper/CBS_POOL
   Device:            tps    kB_read/s    kB_wrtn/s    kB_read    kB_wrtn
   dm-10          1832.93      5119.70      2230.60 3097553002 1349574808


# cat /proc/partitions
major minor  #blocks  name
253       14  104857600 dm-14

# /sys/kernel/scst_tgt/targets/iscsi/<TARGETS>/luns/0/device -> ../../../../../devices/77d8d090-bb66-49d1-a9af-2d0810aa3ce1
[tester@cloudistics-storage-316441dbf1c94b36beca9e62b4e950a2 ~]$ readlink -f /sys/kernel/scst_tgt/targets/iscsi/iqn.2015-01.com.cloudistics\:6e807fd0-1786-43cd-9ef0-41417a8a8cbc/luns/0/device
/sys/kernel/scst_tgt/devices/6e807fd0-1786-43cd-9ef0-41417a8a8cbc

[tester@cloudistics-storage-316441dbf1c94b36beca9e62b4e950a2 ~]$ cat /sys/kernel/scst_tgt/devices/6e807fd0-1786-43cd-9ef0-41417a8a8cbc/filename                                                                                                                                 
/dev/mapper/DISK_6e807fd0178643cd9ef041417a8a8cbc
[key]
```

## cgroups
```
# RHEL 7 (preferred way)
systemd-cgls
systemd-cgtop
systemd-run -unit=UNIT_NAME -slice=SLICE.NAME COMMAND
systemctl set-property

cat /proc/cgroups

# list all subsystems (resource controllers)
lssubsys

# create cgroups inside your cgroup by using mkdir in this directory.
mkdir my_sub_cs

# remove a cgroup
rmdir my_sub_cs

# RHEL mount location
/sys/fs/cgroup/

# add pid to the cgroup
echo pid > /sys/fs/cgroup/<restype>/<userclass>/tasks

# find out cgroup of a particular process
systemctl status PID | grep CGroup
cat /proc/PID/cgroup 
cat /proc/self/cgroup

# find out cgroups version 
cat /proc/filesystems | grep cgroup
If your system supports cgroupv2, you would see:
nodev   cgroup
nodev   cgroup2
cat /proc/mounts

# Attaching processes
# use the cgroup.procs file instead of the tasks file to move all threads in a threadgroup at once.
# Echoing the PID of any task in a threadgroup to cgroup.procs causes all tasks in that threadgroup to be attached to the cgroup. 
# Writing 0 to cgroup.procs moves all tasks in the writing task's threadgroup.
echo PID > tasks
```

## systemctl 
```
systemctl enable
/usr/lib/systemd/system/

systemctl set-property --runtime name property=value
sudo systemctl set-property --runtime cloudistics-storage-controller.service BlockIOWriteBandwidth="/dev/mapper/DISK_6e807fd0178643cd9ef041417a8a8cbc 1M"

systemctl show cloudistics-storage-controller.service  | grep BlockIO
BlockIOWriteBandwidth=/dev/mapper/DISK_6e807fd0178643cd9ef041417a8a8cbc 1000000
```

## udev rules
```
# RHEL udev system rules
/lib/udev/rules.d

# user udev rules
/etc/udev/rules.d/

# top-level device paths can be classified as sysfs directories which contain a dev file
find /sys -name dev

# tool you can use to construct rules
# Starting from RHEL6, udevinfo is no more exist. Use udevadm info instead.
# udevinfo -a -p /sys/class/net/eth0
udevadm info -a -p /sys/class/net/eth0

# get available device major ids
cat /proc/devices

# * - match any character, zero or more times
# ? - match any character exactly once
# [] - match any single character specified in the brackets, ranges are also permitted

# reload rules
udevadm control --reload
udevadm control --reload-rules
udevadm control --reload-rules && udevadm trigger

# get an entry for each action taken by KERNEL and UDEV. Typically add, change, remove
udevadm monitor
udevadm monitor --property

# This removes the entry from the cgroup. If you then cat blkio.throttle.write_bps_device, you will not see the entry any more.
echo "$MAJOR:$MINOR 0" > blkio.throttle.write_bps_device
```

## options (arguments) parsing for the Bash scripts
```
getopts
# mode advanced version with long options support
getopt
```

## GDB
```
# remote 
sudo yum install gdb-gdbserver
gdbserver --attach :remote-port process-id
gdbserver --attach :9999 process-id
# local 
(gdb) target remote remote-ip:remote-port
(gdb) target remote 10.200.1.5:9999

info proc
info proc status
info proc all

info threads

info sources
info sharedlibrary

info files 

# forces GDB to load symbols for the specified shared libraries or all loaded shared libraries.
# Normally, GDB will load the shared library symbols automatically
sharedlibrary

symbol-file /home/dtkachenko/proj/cldtx/engine/build/Linux/Debug/bin/cloudistics-engine

backtrace
bt

list

b SnapshotSlamActionHandler-inl.h:120

continue

help running
step
next

```

## NETCAT
etworking utility for reading from and writing to network connections using TCP or UDP. 
The command is designed to be a dependable back-end that can be used directly or easily driven by other programs and scripts.
At the same time, it is a feature-rich network debugging and investigation tool, since it can produce almost any kind of connection its user could need and has a number of built-in capabilities.
```
nc -u 127.0.0.1 8126
```

## Disk Usage
```
# Show disk usage for directories sorted 
du -mh /home | sort -h

# Show disk usage for files and directories sorted
du -ah /home | sort -h

# Disk utilization per mountpoint
df -h
```

## Record everything on terminal into the file
```
script
```

## In centos,how to switch to default gcc after switched to a higher version of gcc with devtoolset
```
# Not sure if the command below is needed:
# yum install centos-release-scl-rh
yum install devtoolset-7
yum install centos-release-scl
scl enable devtoolset-7 bash
```


## mount a ftp host as a local directory
```
curlftpfs IP:PORT ./MOUNT-POINT
```

## start ftpd on the specific folder
```
tcpsvd -vE 0.0.0.0 1024 ftpd -w /FOLDER
```
