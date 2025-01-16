FROM ubuntu:latest

RUN apt update -y && apt upgrade -y && \
    apt install wget libaio1t64 nodejs npm alien -y && \
    npm install n8n@latest oracledb -g

WORKDIR /tmp

# Get instantclient rpm files
RUN wget https://download.oracle.com/otn_software/linux/instantclient/oracle-instantclient-basic-linuxx64.rpm

# Install intantclient with Alien
RUN alien -i oracle-instantclient-basic-linuxx64.rpm

# Create a symbolic link from libaio.so.1t64 with libaio.so.1 - https://askubuntu.com/questions/1512196/libaio1-on-noble
RUN ln -s /usr/lib/x86_64-linux-gnu/libaio.so.1t64 /usr/lib/x86_64-linux-gnu/libaio.so.1

RUN rm oracle-instantclient-basic-linuxx64.rpm

WORKDIR /app

EXPOSE 5678:5678

ENTRYPOINT ["n8n"]
