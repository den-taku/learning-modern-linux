#!/bin/bash

set -eux

dmidecode
lscpu # cat /proc/cpuinfo

ls /proc/self # peek a part of task_struct

ps -j
ls -al /proc/$$/task/$$

lscpu -C # cache size
cat /proc/meminfo
grep MemTotal /proc/meminfo

ip link
ip route

ls -al /sys/devices

mount

strace ls 2> hoge; cat hoge | head; rm hoge
strace -c curl -s https://mhausenblas.info > /dev/null

uname -srm

find /lib/modules/$(uname -r) -type f -name '*.ko*' | wc
find /lib/modules/$(uname -r) -type f -name '*.ko*' | head

lsmod
modprobe --show-depends async_memcpy
modprobe --show-depends gpio-max7301


# kernel's components
# - process
# - memory
# - network
# - file system
# - device deriver

# + dmidecode
# # dmidecode 3.3
# # No SMBIOS nor DMI entry point found, sorry.
# + lscpu
# Architecture:                    aarch64
# CPU op-mode(s):                  32-bit, 64-bit
# Byte Order:                      Little Endian
# CPU(s):                          4
# On-line CPU(s) list:             0-3
# Thread(s) per core:              1
# Core(s) per socket:              4
# Socket(s):                       1
# Vendor ID:                       ARM
# Model:                           3
# Model name:                      Cortex-A72
# Stepping:                        r0p3
# CPU max MHz:                     1800.0000
# CPU min MHz:                     600.0000
# BogoMIPS:                        108.00
# L1d cache:                       128 KiB
# L1i cache:                       192 KiB
# L2 cache:                        1 MiB
# Vulnerability Itlb multihit:     Not affected
# Vulnerability L1tf:              Not affected
# Vulnerability Mds:               Not affected
# Vulnerability Meltdown:          Not affected
# Vulnerability Mmio stale data:   Not affected
# Vulnerability Retbleed:          Not affected
# Vulnerability Spec store bypass: Vulnerable
# Vulnerability Spectre v1:        Mitigation; __user pointer sanitization
# Vulnerability Spectre v2:        Vulnerable
# Vulnerability Srbds:             Not affected
# Vulnerability Tsx async abort:   Not affected
# Flags:                           fp asimd evtstrm crc32 cpuid
# + ls /proc/self
# attr	   cgroup      comm		cwd	 fd	  io	   loginuid   mem	 mountstats  oom_adj	    pagemap	 root	    sessionid  smaps_rollup  statm    task	      uid_map
# autogroup  clear_refs  coredump_filter	environ  fdinfo   latency  map_files  mountinfo  net	     oom_score	    personality  sched	    setgroups  stack	     status   timens_offsets  wchan
# auxv	   cmdline     cpuset		exe	 gid_map  limits   maps       mounts	 ns	     oom_score_adj  projid_map	 schedstat  smaps      stat	     syscall  timerslack_ns
# + ps -j
#     PID    PGID     SID TTY          TIME CMD
#     714     714     714 pts/0    00:00:00 bash
#    5799    5799     714 pts/0    00:00:00 commands.sh
#    5803    5799     714 pts/0    00:00:00 ps
# + ls -al /proc/5799/task/5799
# total 0
# dr-xr-xr-x  7 raspi raspi 0 Apr  8 02:56 .
# dr-xr-xr-x  3 raspi raspi 0 Apr  8 02:56 ..
# dr-xr-xr-x  2 raspi raspi 0 Apr  8 02:56 attr
# -r--------  1 raspi raspi 0 Apr  8 02:56 auxv
# -r--r--r--  1 raspi raspi 0 Apr  8 02:56 cgroup
# --w-------  1 raspi raspi 0 Apr  8 02:56 clear_refs
# -r--r--r--  1 raspi raspi 0 Apr  8 02:56 cmdline
# -rw-r--r--  1 raspi raspi 0 Apr  8 02:56 comm
# -r--r--r--  1 raspi raspi 0 Apr  8 02:56 cpuset
# lrwxrwxrwx  1 raspi raspi 0 Apr  8 02:56 cwd -> /home/raspi
# -r--------  1 raspi raspi 0 Apr  8 02:56 environ
# lrwxrwxrwx  1 raspi raspi 0 Apr  8 02:56 exe -> /usr/bin/bash
# dr-x------  2 raspi raspi 0 Apr  8 02:56 fd
# dr-xr-xr-x  2 raspi raspi 0 Apr  8 02:56 fdinfo
# -rw-r--r--  1 raspi raspi 0 Apr  8 02:56 gid_map
# -r--------  1 raspi raspi 0 Apr  8 02:56 io
# -r--r--r--  1 raspi raspi 0 Apr  8 02:56 latency
# -r--r--r--  1 raspi raspi 0 Apr  8 02:56 limits
# -rw-r--r--  1 raspi raspi 0 Apr  8 02:56 loginuid
# -r--r--r--  1 raspi raspi 0 Apr  8 02:56 maps
# -rw-------  1 raspi raspi 0 Apr  8 02:56 mem
# -r--r--r--  1 raspi raspi 0 Apr  8 02:56 mountinfo
# -r--r--r--  1 raspi raspi 0 Apr  8 02:56 mounts
# dr-xr-xr-x 62 raspi raspi 0 Apr  8 02:56 net
# dr-x--x--x  2 raspi raspi 0 Apr  8 02:56 ns
# -rw-r--r--  1 raspi raspi 0 Apr  8 02:56 oom_adj
# -r--r--r--  1 raspi raspi 0 Apr  8 02:56 oom_score
# -rw-r--r--  1 raspi raspi 0 Apr  8 02:56 oom_score_adj
# -r--------  1 raspi raspi 0 Apr  8 02:56 pagemap
# -r--------  1 raspi raspi 0 Apr  8 02:56 personality
# -rw-r--r--  1 raspi raspi 0 Apr  8 02:56 projid_map
# lrwxrwxrwx  1 raspi raspi 0 Apr  8 02:56 root -> /
# -rw-r--r--  1 raspi raspi 0 Apr  8 02:56 sched
# -r--r--r--  1 raspi raspi 0 Apr  8 02:56 schedstat
# -r--r--r--  1 raspi raspi 0 Apr  8 02:56 sessionid
# -rw-r--r--  1 raspi raspi 0 Apr  8 02:56 setgroups
# -r--r--r--  1 raspi raspi 0 Apr  8 02:56 smaps
# -r--r--r--  1 raspi raspi 0 Apr  8 02:56 smaps_rollup
# -r--------  1 raspi raspi 0 Apr  8 02:56 stack
# -r--r--r--  1 raspi raspi 0 Apr  8 02:56 stat
# -r--r--r--  1 raspi raspi 0 Apr  8 02:56 statm
# -r--r--r--  1 raspi raspi 0 Apr  8 02:56 status
# -r--------  1 raspi raspi 0 Apr  8 02:56 syscall
# -rw-r--r--  1 raspi raspi 0 Apr  8 02:56 uid_map
# -r--r--r--  1 raspi raspi 0 Apr  8 02:56 wchan
# + lscpu -C
# NAME ONE-SIZE ALL-SIZE WAYS TYPE        LEVEL SETS PHY-LINE COHERENCY-SIZE
# L1d       32K     128K    2 Data            1  256                      64
# L1i       48K     192K    3 Instruction     1  256                      64
# L2         1M       1M   16 Unified         2 1024                      64
# + cat /proc/meminfo
# MemTotal:        7999812 kB
# MemFree:         5879844 kB
# MemAvailable:    7766164 kB
# Buffers:           39088 kB
# Cached:          1821968 kB
# SwapCached:            0 kB
# Active:           162460 kB
# Inactive:        1723916 kB
# Active(anon):      25252 kB
# Inactive(anon):     1232 kB
# Active(file):     137208 kB
# Inactive(file):  1722684 kB
# Unevictable:          16 kB
# Mlocked:              16 kB
# SwapTotal:        102396 kB
# SwapFree:         102396 kB
# Zswap:                 0 kB
# Zswapped:              0 kB
# Dirty:                40 kB
# Writeback:             0 kB
# AnonPages:         25344 kB
# Mapped:            39336 kB
# Shmem:              1156 kB
# KReclaimable:     151088 kB
# Slab:             176620 kB
# SReclaimable:     151088 kB
# SUnreclaim:        25532 kB
# KernelStack:        2504 kB
# PageTables:         1688 kB
# SecPageTables:         0 kB
# NFS_Unstable:          0 kB
# Bounce:                0 kB
# WritebackTmp:          0 kB
# CommitLimit:     4102300 kB
# Committed_AS:     195564 kB
# VmallocTotal:   259653632 kB
# VmallocUsed:        9776 kB
# VmallocChunk:          0 kB
# Percpu:              656 kB
# CmaTotal:         524288 kB
# CmaFree:          497068 kB
# + grep MemTotal /proc/meminfo
# MemTotal:        7999812 kB
# + ip link
# 1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
#     link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
# 2: eth0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq state DOWN mode DEFAULT group default qlen 1000
#     link/ether e4:5f:01:de:a4:72 brd ff:ff:ff:ff:ff:ff
# 3: wlan0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP mode DORMANT group default qlen 1000
#     link/ether e4:5f:01:de:a4:74 brd ff:ff:ff:ff:ff:ff
# + ip route
# default via 192.168.10.1 dev wlan0 proto dhcp src 192.168.10.104 metric 303 
# 192.168.10.0/24 dev wlan0 proto dhcp scope link src 192.168.10.104 metric 303 
# + ls -al /sys/devices
# total 0
# drwxr-xr-x 10 root root 0 Aug  7  2022 .
# dr-xr-xr-x 12 root root 0 Jan  1  1970 ..
# drwxr-xr-x  6 root root 0 Apr  7 21:59 armv8_cortex_a72
# drwxr-xr-x  3 root root 0 Apr  7 21:59 breakpoint
# drwxr-xr-x  4 root root 0 Apr  7 21:59 kprobe
# drwxr-xr-x 27 root root 0 Aug  7  2022 platform
# drwxr-xr-x  3 root root 0 Apr  7 21:59 software
# drwxr-xr-x  6 root root 0 Apr  7 21:59 system
# drwxr-xr-x  3 root root 0 Apr  7 21:59 tracepoint
# drwxr-xr-x 20 root root 0 Aug  7  2022 virtual
# + mount
# /dev/mmcblk0p2 on / type ext4 (rw,noatime)
# devtmpfs on /dev type devtmpfs (rw,relatime,size=3735680k,nr_inodes=933920,mode=755)
# proc on /proc type proc (rw,relatime)
# sysfs on /sys type sysfs (rw,nosuid,nodev,noexec,relatime)
# securityfs on /sys/kernel/security type securityfs (rw,nosuid,nodev,noexec,relatime)
# tmpfs on /dev/shm type tmpfs (rw,nosuid,nodev)
# devpts on /dev/pts type devpts (rw,nosuid,noexec,relatime,gid=5,mode=620,ptmxmode=000)
# tmpfs on /run type tmpfs (rw,nosuid,nodev,size=1599964k,nr_inodes=819200,mode=755)
# tmpfs on /run/lock type tmpfs (rw,nosuid,nodev,noexec,relatime,size=5120k)
# cgroup2 on /sys/fs/cgroup type cgroup2 (rw,nosuid,nodev,noexec,relatime,nsdelegate,memory_recursiveprot)
# pstore on /sys/fs/pstore type pstore (rw,nosuid,nodev,noexec,relatime)
# bpf on /sys/fs/bpf type bpf (rw,nosuid,nodev,noexec,relatime,mode=700)
# systemd-1 on /proc/sys/fs/binfmt_misc type autofs (rw,relatime,fd=30,pgrp=1,timeout=0,minproto=5,maxproto=5,direct)
# mqueue on /dev/mqueue type mqueue (rw,nosuid,nodev,noexec,relatime)
# debugfs on /sys/kernel/debug type debugfs (rw,nosuid,nodev,noexec,relatime)
# sunrpc on /run/rpc_pipefs type rpc_pipefs (rw,relatime)
# tracefs on /sys/kernel/tracing type tracefs (rw,nosuid,nodev,noexec,relatime)
# fusectl on /sys/fs/fuse/connections type fusectl (rw,nosuid,nodev,noexec,relatime)
# configfs on /sys/kernel/config type configfs (rw,nosuid,nodev,noexec,relatime)
# /dev/mmcblk0p1 on /boot type vfat (rw,relatime,fmask=0022,dmask=0022,codepage=437,iocharset=ascii,shortname=mixed,errors=remount-ro)
# tmpfs on /run/user/1000 type tmpfs (rw,nosuid,nodev,relatime,size=799980k,nr_inodes=199995,mode=700,uid=1000,gid=1000)
# + strace ls
# commands.sh  hoge  learning-modern-linux  result
# + cat hoge
# + head
# execve("/usr/bin/ls", ["ls"], 0x7fc8de23a0 /* 22 vars */) = 0
# brk(NULL)                               = 0x5597715000
# faccessat(AT_FDCWD, "/etc/ld.so.preload", R_OK) = -1 ENOENT (No such file or directory)
# openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) = 3
# fstat(3, {st_mode=S_IFREG|0644, st_size=30486, ...}) = 0
# mmap(NULL, 30486, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7f92f9b000
# close(3)                                = 0
# openat(AT_FDCWD, "/lib/aarch64-linux-gnu/libselinux.so.1", O_RDONLY|O_CLOEXEC) = 3
# read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0\267\0\1\0\0\0\20t\0\0\0\0\0\0"..., 832) = 832
# fstat(3, {st_mode=S_IFREG|0644, st_size=166032, ...}) = 0
# + rm hoge
# + strace -c curl -s https://mhausenblas.info
# % time     seconds  usecs/call     calls    errors syscall
# ------ ----------- ----------- --------- --------- ----------------
#  23.44    0.002355          58        40           ppoll
#  19.56    0.001965          27        71           mprotect
#  12.29    0.001235          14        88           mmap
#   8.41    0.000845           8       101           rt_sigaction
#   7.05    0.000708           4       149         6 read
#   5.90    0.000593          13        44         3 openat
#   4.83    0.000485           9        49           close
#   2.89    0.000290          14        20           futex
#   2.85    0.000286          16        17           brk
#   2.51    0.000252           5        43           fstat
#   1.36    0.000137           6        20           getpid
#   1.28    0.000129         129         1           clone
#   0.80    0.000080          80         1           munmap
#   0.78    0.000078          13         6           fcntl
#   0.73    0.000073          73         1         1 connect
#   0.68    0.000068          34         2           socketpair
#   0.60    0.000060          15         4           rt_sigprocmask
#   0.60    0.000060          30         2           socket
#   0.50    0.000050          12         4           setsockopt
#   0.44    0.000044          44         1           pipe2
#   0.40    0.000040          20         2         2 faccessat
#   0.37    0.000037          12         3         2 ioctl
#   0.36    0.000036          18         2           getrandom
#   0.31    0.000031          15         2         2 newfstatat
#   0.26    0.000026          26         1           sysinfo
#   0.16    0.000016          16         1           prlimit64
#   0.15    0.000015          15         1           set_tid_address
#   0.15    0.000015          15         1           set_robust_list
#   0.12    0.000012          12         1           getsockname
#   0.12    0.000012          12         1           getpeername
#   0.12    0.000012          12         1           getsockopt
#   0.00    0.000000           0         1           lseek
#   0.00    0.000000           0        13           write
#   0.00    0.000000           0         1           execve
# ------ ----------- ----------- --------- --------- ----------------
# 100.00    0.010045          14       695        16 total
# + uname -srm
# Linux 6.1.21-v8+ aarch64
# + wc
# ++ uname -r
# + find /lib/modules/6.1.21-v8+ -type f -name '*.ko*'
#    1764    1764  116623
# + head
# ++ uname -r
# + find /lib/modules/6.1.21-v8+ -type f -name '*.ko*'
# /lib/modules/6.1.21-v8+/kernel/net/netrom/netrom.ko.xz
# /lib/modules/6.1.21-v8+/kernel/net/openvswitch/vport-gre.ko.xz
# /lib/modules/6.1.21-v8+/kernel/net/openvswitch/vport-vxlan.ko.xz
# /lib/modules/6.1.21-v8+/kernel/net/openvswitch/openvswitch.ko.xz
# /lib/modules/6.1.21-v8+/kernel/net/bluetooth/bnep/bnep.ko.xz
# /lib/modules/6.1.21-v8+/kernel/net/bluetooth/bluetooth.ko.xz
# /lib/modules/6.1.21-v8+/kernel/net/bluetooth/hidp/hidp.ko.xz
# /lib/modules/6.1.21-v8+/kernel/net/bluetooth/rfcomm/rfcomm.ko.xz
# /lib/modules/6.1.21-v8+/kernel/net/bluetooth/bluetooth_6lowpan.ko.xz
# /lib/modules/6.1.21-v8+/kernel/net/nsh/nsh.ko.xz
# + lsmod
# Module                  Size  Used by
# cmac                   16384  3
# algif_hash             16384  1
# aes_arm64              16384  3
# aes_generic            36864  1 aes_arm64
# algif_skcipher         16384  1
# af_alg                 28672  6 algif_hash,algif_skcipher
# bnep                   24576  2
# hci_uart               53248  1
# btbcm                  24576  1 hci_uart
# bluetooth             565248  26 hci_uart,btbcm,bnep
# ecdh_generic           16384  2 bluetooth
# ecc                    36864  1 ecdh_generic
# libaes                 16384  3 aes_arm64,bluetooth,aes_generic
# 8021q                  32768  0
# garp                   16384  1 8021q
# stp                    16384  1 garp
# llc                    16384  2 stp,garp
# joydev                 28672  0
# brcmfmac              331776  0
# brcmutil               24576  1 brcmfmac
# vc4                   331776  4
# snd_soc_hdmi_codec     20480  2
# v3d                    90112  0
# cfg80211              925696  1 brcmfmac
# drm_display_helper     16384  1 vc4
# cec                    53248  1 vc4
# drm_dma_helper         20480  1 vc4
# gpu_sched              49152  1 v3d
# drm_kms_helper        204800  4 drm_dma_helper,vc4
# bcm2835_codec          49152  0
# rpivid_hevc            53248  0
# bcm2835_isp            28672  0
# snd_soc_core          274432  2 vc4,snd_soc_hdmi_codec
# drm_shmem_helper       24576  1 v3d
# snd_bcm2835            28672  0
# v4l2_mem2mem           45056  2 bcm2835_codec,rpivid_hevc
# bcm2835_v4l2           45056  0
# bcm2835_mmal_vchiq     36864  3 bcm2835_codec,bcm2835_v4l2,bcm2835_isp
# snd_compress           20480  1 snd_soc_core
# snd_pcm_dmaengine      20480  1 snd_soc_core
# snd_pcm               139264  5 snd_bcm2835,snd_soc_hdmi_codec,snd_compress,snd_soc_core,snd_pcm_dmaengine
# videobuf2_dma_contig    20480  3 bcm2835_codec,rpivid_hevc,bcm2835_isp
# rfkill                 32768  6 bluetooth,cfg80211
# raspberrypi_hwmon      16384  0
# videobuf2_vmalloc      16384  1 bcm2835_v4l2
# videobuf2_memops       16384  2 videobuf2_vmalloc,videobuf2_dma_contig
# videobuf2_v4l2         32768  5 bcm2835_codec,bcm2835_v4l2,rpivid_hevc,v4l2_mem2mem,bcm2835_isp
# videobuf2_common       69632  9 bcm2835_codec,videobuf2_vmalloc,videobuf2_dma_contig,videobuf2_v4l2,bcm2835_v4l2,rpivid_hevc,v4l2_mem2mem,videobuf2_memops,bcm2835_isp
# snd_timer              36864  1 snd_pcm
# videodev              274432  7 bcm2835_codec,videobuf2_v4l2,bcm2835_v4l2,videobuf2_common,rpivid_hevc,v4l2_mem2mem,bcm2835_isp
# i2c_brcmstb            16384  0
# snd                   106496  6 snd_bcm2835,snd_soc_hdmi_codec,snd_timer,snd_compress,snd_soc_core,snd_pcm
# vc_sm_cma              36864  2 bcm2835_mmal_vchiq,bcm2835_isp
# mc                     61440  7 videodev,bcm2835_codec,videobuf2_v4l2,videobuf2_common,rpivid_hevc,v4l2_mem2mem,bcm2835_isp
# syscopyarea            16384  1 drm_kms_helper
# sysfillrect            16384  1 drm_kms_helper
# sysimgblt              16384  1 drm_kms_helper
# fb_sys_fops            16384  1 drm_kms_helper
# uio_pdrv_genirq        16384  0
# nvmem_rmem             16384  0
# uio                    24576  1 uio_pdrv_genirq
# drm                   581632  8 gpu_sched,drm_kms_helper,drm_dma_helper,v3d,vc4,drm_shmem_helper,drm_display_helper
# fuse                  135168  1
# drm_panel_orientation_quirks    28672  1 drm
# backlight              24576  1 drm
# ip_tables              32768  0
# x_tables               53248  1 ip_tables
# ipv6                  557056  26
# + modprobe --show-depends async_memcpy
# insmod /lib/modules/6.1.21-v8+/kernel/crypto/async_tx/async_tx.ko.xz 
# insmod /lib/modules/6.1.21-v8+/kernel/crypto/async_tx/async_memcpy.ko.xz 
# + modprobe --show-depends gpio-max7301
# insmod /lib/modules/6.1.21-v8+/kernel/drivers/gpio/gpio-max730x.ko.xz 
# insmod /lib/modules/6.1.21-v8+/kernel/drivers/gpio/gpio-max7301.ko.xz 