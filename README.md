# DataX-PostgreSQL-capture-file-changes
This app using [DataX](https://github.com/alibaba/DataX.git) app developed by Alibaba. It capture file changes according to timestamp column in database.

## Requirement
- Docker
- PostgreSQL Database

## Quick Start Guide
1. Prepare your PostgreSQL Database credential (host, port, user, password)
2. Unzip [DataX toolkit](https://datax-opensource.oss-cn-hangzhou.aliyuncs.com/202309/datax.tar.gz) inside cloned repository folder.
3. Prepare a DataX config JSON file. Take a look at the sample file in `src/config` folder. You can find complete documentation in DataX repository. In the querySql section, you can create your own SQL query according to need without modifying WHERE part if you do not have understanding in SQL.You can add extra condition by add more AND at the end of the query. 
4. Build the docker image `docker build -t {IMAGE NAME AND TAG} {DOCKERFILE PATH}`. Please read the dockerfile step and to minimise image size, copy only necessary plugin. You can find example inside `Dockerfile.pgtotxt` file.
5. Run the following command to start a container using the docker image we have just created.  `docker run -d --link {POSTGRES DOCKER CONTAINER} -v {LOCAL PATH TO SRC FOLDER}:/opt/datax/src/ {DATAX DOCKER IMAGE NAME}`
6. Sample DataX output can be found under `src/result` folder.
