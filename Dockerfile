FROM dolt

#RUN yum install -y curl \
    #&& curl -L https://github.com/dolthub/dolt/releases/latest/download/install.sh | bash \
    #&& dolt config --global --add user.name "FIRST LAST" \
    #&& dolt config --global --add user.email "FIRST@LAST.com"
#COPY ./dolt /usr/local/bin/

#ENV PATH="/usr/local/bin/dolt:${PATH}"
#COPY /Users/max-hoffman/go/src/github.com/dolthub/dolt/go /home/dolt
#WORKDIR /home/dolt
#RUN go install ./...


EXPOSE 3306
ENTRYPOINT ["dolt"]
CMD ["sql-server", "-l", "trace", "--host", "0.0.0.0"]
