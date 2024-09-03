# 使用 rocketmq-ci 作为基础镜像
FROM rocketmq-ci:v1.0

# 定义工作目录
ENV WORKDIR /home/rocketmq/rocketmq-5.2.0/bin

# 更新包管理器索引，并安装 SSH 服务
RUN apt-get update && \
    apt-get install -y openssh-server && \
    apt-get clean

# 创建 SSH 目录并设置 SSH 配置
RUN mkdir /var/run/sshd && \
    mkdir -p /root/.ssh && \
    chmod 700 /root/.ssh && \
    ssh-keygen -A

# 配置 SSH 允许空密码登录
RUN echo 'PermitEmptyPasswords yes' >> /etc/ssh/sshd_config

# 确保 root 用户密码为空
RUN passwd -d root

# 复制启动脚本到工作目录
COPY mqbroker-ssh ${WORKDIR}/mqbroker-ssh
COPY mqnamesrv-ssh ${WORKDIR}/mqnamesrv-ssh
RUN chmod +x ${WORKDIR}/mqbroker-ssh ${WORKDIR}/mqnamesrv-ssh

# 设置 SSH 服务为前台运行
CMD ["/usr/sbin/sshd", "-D"]

# 暴露 SSH 端口
EXPOSE 22
