FROM centos:7


# Install JDK 1.8
RUN yum -y update && \
    yum -y install java-1.8.0-openjdk-devel

# Download from web
# RUN yum -y install wget && \
    # 6.0.10
    # wget https://fineoverseas-server.obs.myhuaweicloud.com/FineBI/EN/6.0.10_2023.05.22/linux_unix_FineBI6_0-EN.sh && \
    # latest
    # wget https://fineoverseas-server.obs.myhuaweicloud.com/FineBI/EN/packages_en/6.0/linux_unix_FineBI6_0-EN.sh && \
    # yum -y remove wget

RUN yum -y clean all

# Use local file
COPY linux_unix_FineBI6_0-EN.sh /

# Install path
ENV path=/usr/local/FineBI6.0
# Virtual memory usage
ENV ram=30000

RUN chmod 777 linux_unix_FineBI6_0-EN.sh
RUN printf '%s\n' o y y y y y y y 1 ${path} ${ram} n n n n | ./linux_unix_FineBI6_0-EN.sh && \
    rm linux_unix_FineBI6_0-EN.sh

# FineBI FCP Exam DB
COPY Exam.db /usr/local/FineBI6.0/webapps/webroot/

# Set the working directory
WORKDIR ${path}

CMD ["run"]
ENTRYPOINT ["./bin/finebi"]