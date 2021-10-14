FROM centos:latest

RUN yum install -y curl \
    && curl -L https://github.com/dolthub/dolt/releases/latest/download/install.sh | bash \
    && dolt config --global --add user.name "FIRST LAST" \
    && dolt config --global --add user.email "FIRST@LAST.com"

EXPOSE 3306
ENTRYPOINT ["dolt"]
CMD ["sql-server", "-l", "trace", "--host", "0.0.0.0"]
