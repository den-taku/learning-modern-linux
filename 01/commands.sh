#!/bin/bash

set -eux

id --user

cat /proc/version

cat /proc/cpuinfo

cat /proc/$$/status | head -n 6