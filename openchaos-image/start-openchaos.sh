#!/bin/sh

JVM_GC_LOG=" -XX:+PrintGCDetails -XX:+PrintGCApplicationStoppedTime  -XX:+UseGCLogFileRotation -XX:NumberOfGCLogFiles=5 -XX:GCLogFileSize=64m  -Xloggc:/dev/shm/benchmark-client-gc_%p.log"

# 启动 OpenChaos
java $JVM_GC_LOG -jar /chaos-framework/ChaosControl.jar "$@"

