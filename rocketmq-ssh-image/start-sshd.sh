#!/bin/sh
exec /usr/sbin/sshd -D &
# 切换回 rocketmq 用户执行剩余的命令
#  su rocketmq -c "$@"
exec "$@"

