#!/bin/bash

set -eux

id --user

cat /proc/version

cat /proc/cpuinfo

cat /proc/$$/status | head -n 6

# + id --user
# 1000
# + cat /proc/version
# Linux version 6.1.21-v8+ (dom@buildbot) (aarch64-linux-gnu-gcc-8 (Ubuntu/Linaro 8.4.0-3ubuntu1) 8.4.0, GNU ld (GNU Binutils for Ubuntu) 2.34) #1642 SMP PREEMPT Mon Apr  3 17:24:16 BST 2023
# + cat /proc/cpuinfo
# processor	: 0
# BogoMIPS	: 108.00
# Features	: fp asimd evtstrm crc32 cpuid
# CPU implementer	: 0x41
# CPU architecture: 8
# CPU variant	: 0x0
# CPU part	: 0xd08
# CPU revision	: 3

# processor	: 1
# BogoMIPS	: 108.00
# Features	: fp asimd evtstrm crc32 cpuid
# CPU implementer	: 0x41
# CPU architecture: 8
# CPU variant	: 0x0
# CPU part	: 0xd08
# CPU revision	: 3

# processor	: 2
# BogoMIPS	: 108.00
# Features	: fp asimd evtstrm crc32 cpuid
# CPU implementer	: 0x41
# CPU architecture: 8
# CPU variant	: 0x0
# CPU part	: 0xd08
# CPU revision	: 3

# processor	: 3
# BogoMIPS	: 108.00
# Features	: fp asimd evtstrm crc32 cpuid
# CPU implementer	: 0x41
# CPU architecture: 8
# CPU variant	: 0x0
# CPU part	: 0xd08
# CPU revision	: 3

# Hardware	: BCM2835
# Revision	: d03115
# Serial		: 10000000f090b702
# Model		: Raspberry Pi 4 Model B Rev 1.5
# + cat /proc/3902/status
# + head -n 6
# Name:	commands.sh
# Umask:	0022
# State:	S (sleeping)
# Tgid:	3902
# Ngid:	0
# Pid:	3902