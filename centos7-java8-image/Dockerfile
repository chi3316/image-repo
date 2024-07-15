FROM centos:7

# 设置阿里云 YUM 镜像仓库地址
RUN curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo && \
    sed -i 's|http://|https://|g' /etc/yum.repos.d/CentOS-Base.repo

ADD jdk-8u202-linux-x64.tar.gz /opt/

ENV JAVA_HOME /opt/jdk1.8.0_202
ENV PATH $JAVA_HOME/bin:$PATH

CMD ["java", "-version"]

