FROM apache/rocketmq:latest

ENV WORKDIR /home/rocketmq/rocketmq-5.2.0/bin

USER root

# 备份原有的 YUM 仓库配置
RUN mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.bak

# 设置阿里云 YUM 镜像仓库地址
RUN curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo && \
    sed -i 's|http://|https://|g' /etc/yum.repos.d/CentOS-Base.repo && \
    yum clean all && \
    yum makecache

# 安装 SSH 服务和 unzip
RUN yum install -y openssh-server unzip && \
    yum clean all

# SSH 相关配置
RUN mkdir /var/run/sshd && \
    mkdir -p /home/rocketmq/.ssh && \
    chmod 700 /home/rocketmq/.ssh && \
    ssh-keygen -A

# 配置 SSH 允许空密码登录
RUN echo 'PermitEmptyPasswords yes' >> /etc/ssh/sshd_config

# 设置 rocketmq 用户密码为空
RUN passwd -d rocketmq

# 确保 rocketmq 用户拥有相关权限
RUN chown -R rocketmq:rocketmq /home/rocketmq /home/rocketmq/.ssh /var/run/sshd
RUN chown root:rocketmq /usr/sbin/sshd && chmod 750 /usr/sbin/sshd
RUN chown -R root:rocketmq /etc/ssh && chmod -R 750 /etc/ssh

# 启动脚本
COPY mqbroker-ssh ${WORKDIR}/mqbroker-ssh
COPY mqnamesrv-ssh ${WORKDIR}/mqnamesrv-ssh
RUN chmod +x ${WORKDIR}/mqbroker-ssh ${WORKDIR}/mqnamesrv-ssh

USER rocketmq

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]

