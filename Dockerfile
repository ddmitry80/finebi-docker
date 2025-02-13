FROM centos:7

RUN sed -i s/mirror.centos.org/vault.centos.org/g /etc/yum.repos.d/*.repo && \
    sed -i s/^#.*baseurl=http/baseurl=http/g /etc/yum.repos.d/*.repo && \
    sed -i s/^mirrorlist=http/#mirrorlist=http/g /etc/yum.repos.d/*.repo

# Install JDK 1.8
RUN yum -y update && \
    yum -y install mc nano ncdu tmux wget curl net-tools && \
    yum -y install java-1.8.0-openjdk-devel && \
    yum -y update && \
    yum -y clean all

# Download from web
# RUN \
    # 6.0.10
    # wget https://fineoverseas-server.obs.myhuaweicloud.com/FineBI/EN/6.0.10_2023.05.22/linux_unix_FineBI6_0-EN.sh && \
    # latest
    # wget https://fineoverseas-server.obs.myhuaweicloud.com/FineBI/EN/packages_en/6.0/linux_unix_FineBI6_0-EN.sh && \

# Use local file
COPY linux_unix_FineBI6_1_4-EN.sh /

# Install path
ENV path=/usr/local/FineBI6.1
# Virtual memory usage
ENV ram=8192

RUN chmod 777 linux_unix_FineBI6_1_4-EN.sh
RUN printf '%s\n' o y y y y y y y 1 ${path} ${ram} n n n n | ./linux_unix_FineBI6_1_4-EN.sh && \
    rm linux_unix_FineBI6_1_4-EN.sh

# FineBI FCP Exam DB
COPY Exam.db /usr/local/FineBI6.1/webapps/webroot/

# Set the working directory
WORKDIR ${path}

CMD ["run"]
ENTRYPOINT ["./bin/finebi"]