FROM apache/rocketmq:latest

# 切换到 root 用户
USER root

# 备份原有的 YUM 仓库配置
RUN mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.bak

# 设置阿里云 YUM 镜像仓库地址并将 http 改为 https
RUN curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo && \
    sed -i 's|http://|https://|g' /etc/yum.repos.d/CentOS-Base.repo && \
    yum clean all && \
    yum makecache

# 安装 SSH 服务
RUN yum install -y openssh-server && \
    yum clean all

# 创建 SSH 目录并设置 SSH 配置
RUN mkdir /var/run/sshd && \
    mkdir -p /root/.ssh && \
    chmod 700 /root/.ssh && \
    ssh-keygen -A

# 配置 SSH 允许空密码登录
RUN echo 'PermitEmptyPasswords yes' >> /etc/ssh/sshd_config

# 确保 root 用户密码为空
RUN passwd -d root

# 添加启动脚本
COPY start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh

# 设置 SSH 服务为前台运行  /usr/sbin/sshd是 OpenSSH 服务的可执行文件路径
CMD ["/usr/sbin/sshd", "-D"]

# 暴露 SSH 端口
EXPOSE 22 
