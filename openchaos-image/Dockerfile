FROM centos-java:8

WORKDIR /chaos-framework

# 安装 OpenSSH,gnuplot
RUN  yum -y install openssh-clients gnuplot && \
     yum clean all

COPY ChaosControl.jar /chaos-framework/ChaosControl.jar

# 启动脚本
COPY start-openchaos.sh /chaos-framework/start-openchaos.sh
RUN chmod +x /chaos-framework/start-openchaos.sh

EXPOSE 8080

CMD ["/bin/sh", "-c", "/chaos-framework/start-openchaos.sh"]

