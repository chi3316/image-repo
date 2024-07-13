FROM openjdk:8-jre-alpine

# 设置工作目录
WORKDIR /chaos-framework

# 复制打包好的 JAR 文件到容器中
COPY ChaosControl.jar /chaos-framework/ChaosControl.jar

# 安装 OpenSSH,gnuplot
RUN apk add --no-cache openssh gnuplot

# 复制公钥和私钥到容器中
COPY id_rsa /root/.ssh/id_rsa
COPY id_rsa.pub /root/.ssh/id_rsa.pub

# 设置适当的权限
RUN chmod 600 /root/.ssh/id_rsa && \
    chmod 644 /root/.ssh/id_rsa.pub

# 创建启动脚本
COPY start-openchaos.sh /chaos-framework/start-openchaos.sh
RUN chmod +x /chaos-framework/start-openchaos.sh

# 暴露端口
EXPOSE 8080

# 运行 OpenChaos
CMD ["/bin/sh", "-c", "/chaos-framework/start-openchaos.sh"]

