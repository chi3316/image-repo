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
    
# 创建 SSH 目录并设置权限
RUN mkdir /var/run/sshd && \
    chmod 755 /var/run/sshd && \
    ssh-keygen -A

# 配置 SSH 以允许公钥认证
RUN sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config

# 允许 rocketmq 用户使用 SSH 免密登录
RUN mkdir -p /home/rocketmq/.ssh && \
    chmod 700 /home/rocketmq/.ssh && \
    chown rocketmq:rocketmq /home/rocketmq/.ssh

# 添加公钥到 authorized_keys
COPY id_rsa.pub /home/rocketmq/.ssh/authorized_keys
RUN chmod 600 /home/rocketmq/.ssh/authorized_keys && \
    chown rocketmq:rocketmq /home/rocketmq/.ssh/authorized_keys

# 确保 sshd 配置文件和主机密钥文件权限正确
RUN chown root:root /etc/ssh/sshd_config && chmod 644 /etc/ssh/sshd_config
RUN chown root:root /etc/ssh/ssh_host_* && chmod 644 /etc/ssh/ssh_host_*

# 确保 /etc/ssh 目录的权限允许其他用户读取其中的文件
RUN chmod 755 /etc/ssh

# 启动 SSH 服务
CMD ["/usr/sbin/sshd", "-D", "-e"]

# 暴露 SSH 端口
EXPOSE 22

# 切换回 rocketmq 用户
USER rocketmq

