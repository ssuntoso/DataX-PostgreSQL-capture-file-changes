FROM ubuntu:24.04

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends wget openjdk-21-jre-headless

RUN wget https://datax-opensource.oss-cn-hangzhou.aliyuncs.com/202309/datax.tar.gz && \
    tar -zxvf datax.tar.gz && \
    mv datax /opt/ && \
    rm datax.tar.gz 

RUN apt-get install -y python3

RUN apt-get purge -y wget && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

COPY run_datax_pg.py /opt/datax/

ENTRYPOINT [ "python3" ]

CMD [ "/opt/datax/run_datax_pg.py", "/opt/datax/bin/datax.py", "/opt/datax/src/config/config.json", "/opt/datax/src/result" ]