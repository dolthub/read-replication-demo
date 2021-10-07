#!/bin/bash

remotesrv_pid=

setup() {
    rm -rf dbs/{reader,writer,remote}

    mkdir -p dbs/{writer,remote}

    remotesrv --http-port 5000 --dir ./dbs/remote &
    remotesrv_pid=$!
}

make_repos() {
    cd writer
    dolt init
    dolt remote add origin http://127.0.0.1:50051/test-org/test-repo
    dolt remote add docker_origin http://remote:50051/test-org/test-repo
    dolt push -u origin main
    #dolt config --local --add DOLT_REPLICATE_TO_REMOTE docker_origin

    cd ..
    dolt clone http://127.0.0.1:50051/test-org/test-repo reader
    cd reader
    dolt remote add docker_origin http://remote:50051/test-org/test-repo
    #dolt config --local --add DOLT_READ_REPLICA_REMOTE docker_origin
}

cleanup() {
    kill $remotesrv_pid
}

setup
make_repos
cleanup
