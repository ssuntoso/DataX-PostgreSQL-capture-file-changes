FROM openjdk:8-alpine

# install python
ENV PYTHONUNBUFFERED=1
RUN apk add --update --no-cache python3 && ln -sf python3 /usr/bin/python
RUN python3 -m ensurepip
RUN pip3 install --no-cache --upgrade pip setuptools

# copy datax required src (make sure to download (https://datax-opensource.oss-cn-hangzhou.aliyuncs.com/202309/datax.tar.gz) and extract datax in current folder)
COPY datax/bin /opt/datax/bin
COPY datax/conf /opt/datax/conf
COPY datax/job /opt/datax/job
COPY datax/lib /opt/datax/lib
COPY datax/script /opt/datax/script
COPY datax/tmp /opt/datax/tmp
COPY datax/plugin /opt/datax/plugin

# copy datax script to auto change last runtime
COPY run_datax_pg.py /opt/datax/

ENTRYPOINT [ "python3" ]
CMD [ "/opt/datax/run_datax_pg.py", "/opt/datax/bin/datax.py", "/opt/datax/src/config/config.json", "/opt/datax/src/result" ]