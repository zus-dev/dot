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

# Find and repalce in files
find ./WHERE -type f -exec sed -i 's/FROM/TO/g' {} +
```

## Replacing stuff
```bash
# Find all files with the specific pattern and replace stuff with sed in those files
grep mega_bytes_per_sec -r . -l | xargs sed -i 's/bandwidth_mega_bytes_per_sec_limit/bandwidth_bytes_per_sec/g'

# Find and replace
find . -type f -name 'xa*' | xargs sed -i 's/asd/dsg/g'
# Find and replace whout xargs
find ./WHERE -type f -exec sed -i 's/FROM/TO/g' {} +
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

docker info
docker history
docker container inspect
docker commit 

alias python-vim='docker run -it --rm -v $(pwd):/src --workdir /src fedeg/python-vim:latest'

# detach from running container shell 
ctrl+p,ctrl+q

# bash into running container 
docker exec -it {container} /bin/bash


# Install Docker Compose on CentOS
sudo curl -L "https://github.com/docker/compose/releases/download/1.23.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version
```

## Kubernetes
```bash
kubectl cluster-info
minikube ssh
uname --all
kubectl get nodes

# How to deploy and expose service
# echo - name of the deployment
kubectl run echo --image=gcr.io/google_containers/echoserver:1.4 --port=8080
kubectl expose deployment echo --type=NodePort
kubectl get service echo --output='jsonpath="{.spec.ports[0].nodePort}"'

# Getting a shell to a pod 
kubectl exec -it <pod-name> -- /bin/bash
# Getting a shell to a specific container inside the pod
kubectl exec -it <pod-name> -c <container-name> -- /bin/bash
# Getting logs out of pod
kubectl logs <pod-name>
# List containers by Pod
kubectl get pods --all-namespaces -o=jsonpath='{range .items[*]}{"\n"}{.metadata.name}{":\t"}{range .spec.containers[*]}{.image}{", "}{end}{end}' | sort
# Get a bit more details abouht the pods 
kubectl get pods -o wide
# Get detailed info about the pod 
kubectl describe pod <pod-name>


kubectl get namespaces
kubectl create namespace pod-example
# creates multi-container pod "examplepod" within the namespace "pod-example"
kubectl create -f ./pod-example.yaml
kubectl --namespace=pod-example get pods
kubectl --namespace=pod-example delete pod examplepod
kubectl delete namespace pod-example

# run an image interactively
kubectl run curler -it --rm --image=pstauffer/curl --restart=Never -- sh

kubectl get pods --field-selector status.phase=Running
kubectl delete pods --field-selector status.phase=Succeeded
```

## Minikube
```bash
minikube ip

minikube delete

# How to use local docker images with Minikube? (Another way is to use Telepresense --swap-deployment
# Start minikube
minikube start
# start minikube with virtualbox
minikube start --vm-driver virtualbox
# Set docker env
eval $(minikube docker-env)
# Build image
docker build -t foo:0.0.1 .
# Run in minikube. Set the imagePullPolicy to Never, otherwise Kubernetes will try to download the image.
kubectl run hello-foo --image=foo:0.0.1 --image-pull-policy=Never
# Check that it's running
kubectl get pods

# scale replicas
kubectl scale --replicas=1 deployment/composition-orchestration

# cleanup with persistent volumes 
kubectl delete all --all
kubectl get pv | tail -n+2 | awk '{print $1}' | xargs -I{} kubectl patch pv {} -p '{"metadata":{"finalizers": null}}'

# cleanup persistent groups
kubectl get pg | tail -n+2 | awk '{print $1}' | xargs -I{} kubectl patch pg {} --type='merge' -p '{"metadata":{"finalizers": null}}'


# Create docker registry secret
kubectl delete secret --all                                                                                                                                                                                        
kubectl create secret docker-registry regcred --docker-server=registry1.corp.cloudistics.com --docker-username=dtkachenko --docker-password='PASSWORD' --docker-email=dimitrian.tkachenko@cloudistics.com
# kubectl patch serviceaccount default -p '{"imagePullSecrets": [{"name": "regcred"}]}'
kubectl create secret docker-registry regcred2 --docker-server=nexus.corp.cloudistics.com:5000 --docker-username=dtkachenko --docker-password='PASSWORD' --docker-email=dimitrian.tkachenko@cloudistics.com
# kubectl patch serviceaccount default -p '{"imagePullSecretsNexus": [{"name": "regcred2"}]}'
```

## Telepresence
```bash
# Run local Docker container in the kubernetes claster
telepresence --swap-deployment composition-fungible-interface --docker-run --rm -it -v $(pwd):/src -u 1000:1000 composition-fungible-interface /bin/bash

# Run local process in the cluster
# vpn tcp: allows to debug 
# conntrack and iptables on Linux for the vpn-tcp method
# https://www.telepresence.io/reference/install#dependencies
sudo yum install conntrack
telepresence --swap-deployment composition-fungible-interface --expose 5001 --run python run_fungible_interface.py
telepresence --swap-deployment composition-orchestration --expose 5002 --run python run_orchestration.py

telepresence --swap-deployment tm-service-tm-collector-agent --expose 51234

# local shell using Telepresence that can access that service, even though the process is local but the service is running inside Minikube:
telepresence --run-shell

# run specified container inside the Minikube:
telepresence --docker-run -it --rm alpine
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

# update commit message to last commit 
git commit --amend

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

# remove tag from local 
git tag -d 0.0.22

# remove tag from remote
git push origin :refs/tags/0.0.22

# git generate ssh key ~/.ssh/id_rsa ~/.ssh/id_rsa.pub
ssh-keygen
# Start the agent, run the following
eval `ssh-agent`
# Add the key to the ssh-agent 
ssh-add ~/.ssh/<private_key_file>
# Add your ssh key to github, bitbucket etc.
cat ~/.ssh/id_rsa.pub
# or
xclip -sel clip < ~/.ssh/id_rsa.pub
# Check it
ssh -T git@bitbucket.org
ssh -T git@github.com

# Make private go repo available global .gitconfig must look like this, so that 'go get' works:
[url "ssh://git@private.repo.net"]
    insteadOf = https://private.repo.net
# e.g.
[url "ssh://git@github.com/fungible-inc"]
    insteadOf = https://github.com/fungible-inc
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

# show process tree for current process
pstree -s $$

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
rsync -aP --info=progress2 source dest
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
Networking utility for reading from and writing to network connections using TCP or UDP. 
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


## dir colors aka directory colors in the linux terminal 
```
dir_colors already exists, renaming it to /home/dtkachenko/.dir_colors.old

The new dircolors have been installed as /home/dtkachenko/.dir_colors.
Add "eval `dircolors /path/to/dircolorsdb`" in your shell configuration file (.bashrc, .zshrc, etc...) to use new dircolors.
For Fish, add the following to config.fish instead:
        eval (dircolors /path/to/dircolorsdb | head -n 1 | sed 's/^LS_COLORS=/set -x LS_COLORS /;s/;$//')
Do not forget to remove old dircolors from your shell configuration file if they were named differently than the one newly installed.
```

## Mount NTFS readonly
sudo mount -t ntfs -o nls=utf8,umask=0222 /dev/nvme0n1p3 /media/c

## apt
```
apt list --installed
```

## FSH description of the file system hierarchy  
```
man hier
```

## Add rw permission recursively
chmod -R ug+rw foldername

## Change screen resolution
xrandr --output eDP-1-1 --mode 1280x720

## Volume from terminal 
```
alsamixer
amixer
```

## Control HiDPI 
```
xrandr --output eDP1 --auto --output DP1 --mode 3840x2160 --panning 5120x2880+1920+0 --scale 1.3334x1.3334 --right-of eDP1
xrandr --output <target> --scale 1x1
xrandr --output eDP-1-1 --mode 1280x720
```

# Brightness controll
```
xrandr --output eDP-1-1 --brightness 0.5
xbacklight -inc 10
```

# keyboard brightness 
```
echo 0 | sudo tee /sys/class/leds/dell\:\:kbd_backlight/brightness
echo 1 | sudo tee /sys/class/leds/dell\:\:kbd_backlight/brightness
echo 2 | sudo tee /sys/class/leds/dell\:\:kbd_backlight/brightness
```

# night-mode 
```
redshift
```

## Keyboard backlight control 
https://wiki.archlinux.org/index.php/Keyboard_backlight
```
# note dell part! (works for XPS 9550)
echo 0 | sudo tee /sys/class/leds/dell\:\:kbd_backlight/brightness
# geniric way
echo 1 | sudo tee /sys/class/leds/tpacpi::kbd_backlight/brightness

## Terminal info file
```
tic - the terminfo entry-description compiler
# terminfo files location:
# /usr/share/terminfo
# /usr/local/share/terminfo

tic -s dvtm.info
2 entries written to /home/dtkachenko/.terminfo
cp /home/dtkachenko/.terminfo/d/dvtm /usr/share/terminfo/d/
cp /home/dtkachenko/.terminfo/d/dvtm-256color /usr/share/terminfo/d/
```

## Count number of files in the git repo
```
git ls-files | xargs wc -l
```

## Suckless
```
abduco - terminal session manager
dvtm - dynamic virtual terminal manager
```

## kafkacat on centos amazonlinux
```
sudo yum update -y
sudo yum install git -y
# make sure you have the necessary dev tools avail,
# or run the ff command:
sudo yum group install “Development Tools” -y
git clone https://github.com/edenhill/kafkacat.git
cd kafkacat/
./bootstrap.sh
./kafkacat -h
```

## kafka k8s cluster
```
# Get inside 
kubectl -n default exec -it tm-service-tm-collector-agent-766f6d769f-km27n -- /bin/sh

# get topics
kubectl -n default exec testclient -- kafka-topics --zookeeper kafka-zookeeper:2181 --list

# consumer
kubectl -n default exec -ti testclient -- kafka-console-consumer --bootstrap-server kafka:9092 --topic TM_Default_Topic --from-beginning

# produce - write to the topic using the netcat
netcat -w 1 -u 192.168.176.8 51234 < ../../test/data/funstop-wsub.bjson
ncat -w 1 -u $(minicube ip) 31287 test/data/funstop-wsub.bjson
# write to the topic using the testagent
kubectl -n default exec -ti testclient -- kafka-console-producer --broker-list kafka-headless:9092 --topic TM_Default_Topic
kafka-console-producer.sh --broker-list localhost:9092 --topic my_topic < my_file.txt

# useful docker images
docker pull confluentinc/cp-kafkacat
docker pull itsthenetwork/alpine-tcpdump

# egarding your issue with running kafkacat locally yesterday (instead of using the testclient), 
# I followed the advice here https://github.com/kubeless/kubeless/issues/966
# to add my minikube ip to /etc/hosts and now I can produce and consume with kafkacat
kafkacat -b 192.168.39.166:31090 -t TM_Default_Topic
    % Auto-selecting Consumer mode (use -P or -C to override)
    A test TMService message
    % Reached end of topic TM_Default_Topic [0] at offset 1
```

## Alpine install whois
```
apk add --update util-linux
```

## Copy to xclipboard
```
$ sudo apt-get install xclip
# Downloads and installs xclip. If you don't have `apt-get`, you might need to use another installer (like `yum`)

$ xclip -sel clip < ~/.ssh/id_rsa.pub
# Copies the contents of the id_rsa.pub file to your clipboard
```

## misk 
```
ps -ev
mysql -h172.17.0.2  -pmy-secret-pw
mysql -h172.17.0.2  -pmy-secret-pw ifdb < ifdb-archive.sql
```

## suckless
```
abduco
dvtm
st 
sudo apt install libx11-dev
sudo apt install libxft-dev
make clean install
```

## Fix wifi disconnect problem:
NOTE: nmcli - part of the [NetworkManager](https://wiki.archlinux.org/index.php/NetworkManager) package
```
journalctl - diagnose 
nmcli c - check connection state
sudo modprobe -r brcmfmac
sudo modprobe  brcmfmac
nmcli d connect wlp2s0
nmcli c up CCSAPT906
```

## How to check battery status
```
upower -i /org/freedesktop/UPower/devices/battery_BAT0
```


## Get you the private IP address of your interfaces:
```
ifconfig -a
ip addr (ip a)
hostname -I | awk '{print $1}'
ip route get 1.2.3.4 | awk '{print $7}'
(Fedora) Wifi-Settings→ click the setting icon next to the Wifi name that you are connected to → Ipv4 and Ipv6 both can be seen
nmcli -p device show
```


## View directory tree structure 
```
tree .
ls -R 
find . -print
du -a .
```


## android 
### EDL mode 
adb reboot edl
adb reboot bootloader
sudo watch /home/dtkachenko/Android/Sdk/platform-tools/fastboot devices
sudo /home/dtkachenko/Android/Sdk/platform-tools/fastboot flashing unlock



## Helm 
```bash
helm fetch bitnami/kafka --version 7.2.6
helm install --dry-run --debug fc  ./fungible-controller/ | less
helm dependency list ./fungible-controller/
helm dependency update ./fungible-controller/

# select particular node for the pod. run the pod on a specific node
helm install ag api-gateway/ --atomic --set nodeSelector.'kubernetes\.io/hostname'=fcc-cluster-1-w3

# api-gateway kafka:
kubectl logs svc/fc-sns-controller | grep -E "connected|TLS|topic"
/workspace/FunAPIGateway/config
/workspace/FunAPIGateway/config # ls
apigateway.yaml
vim restapi/configure_gateway.go 
```


## HA Solution
```
olutions which we are trying to explore
Evaluating two HA solutions 
https://portworx.com/
https://storageos.com/
Other potential solutions
https://www.quobyte.com/containers
https://kadalu.io/docs/k8s-storage/latest/introduction
https://rook.io/
```

## Network Manager
https://wiki.archlinux.org/index.php/NetworkManager
```
nmcli
nmtui
```
