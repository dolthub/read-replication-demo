FROM dolt

WORKDIR /var/remotes
EXPOSE 50051
EXPOSE 5000
ENTRYPOINT ["remotesrv"]
CMD ["--http-port", "5000", "--http-host", "remote", "--dir", "."]
