FROM golang:1.18

RUN git clone https://github.com/dolthub/dolt.git /var/dolt &&\
        cd /var/dolt/go &&\
        go build -o remotesrv ./utils/remotesrv

WORKDIR /var/remotes
EXPOSE 50051
EXPOSE 5000
ENTRYPOINT ["/var/dolt/go/remotesrv"]
CMD ["--http-port", "5000", "--http-host", "remote", "--dir", "."]
