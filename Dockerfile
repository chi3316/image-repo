FROM apache/rocketmq:latest

USER root

# 备份原有的 yum 仓库配置，后面本来想恢复的，但是无法访问到源仓库会报错，就先只备份
RUN mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.bak

# 设置阿里云 yum 镜像仓库
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

# 允许 rocketmq 用户使用 SSH 免密登录
RUN mkdir -p /home/rocketmq/.ssh && \
    chmod 700 /home/rocketmq/.ssh && \
    chown rocketmq:rocketmq /home/rocketmq/.ssh

# 添加公钥到 authorized_keys
COPY id_rsa.pub /home/rocketmq/.ssh/authorized_keys
RUN chmod 600 /home/rocketmq/.ssh/authorized_keys && \
    chown rocketmq:rocketmq /home/rocketmq/.ssh/authorized_keys

# 确保 ssh 守护进程 sshd 的配置文件能让普通用户读取
RUN chown root:root /etc/ssh/sshd_config && chmod 644 /etc/ssh/sshd_config
RUN chown root:root /etc/ssh/ssh_host_* && chmod 644 /etc/ssh/ssh_host_*
RUN chmod 755 /etc/ssh

# 启动 SSH 服务
CMD ["/usr/sbin/sshd", "-D", "-e"]

# 暴露 SSH 端口
EXPOSE 22

# 切换回 rocketmq 用户
USER rocketmq
