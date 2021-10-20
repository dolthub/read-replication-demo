#!/bin/bash

remotesrv_pid=

setup() {
    rm -rf dbs

    mkdir -p dbs/{source,remote}

    remotesrv --http-port 5000 --dir ./dbs/remote &
    remotesrv_pid=$!
}

make_repos() {
    cd dbs

    cd source
    dolt init
    dolt config --local --add user.name "Max Hoffman"
    dolt config --local --add user.email "max@dolthub.com"
    dolt remote add origin http://localhost:50051/test-org/test-repo
    dolt push -u origin main
    dolt remote remove origin
    dolt remote add docker_origin http://remote:50051/test-org/test-repo
    dolt config --local --add DOLT_REPLICATE_TO_REMOTE docker_origin

    cd ..
    dolt clone http://localhost:50051/test-org/test-repo replica
    cd replica
    dolt config --local --add user.name "Max Hoffman"
    dolt config --local --add user.email "max@dolthub.com"
    dolt remote remove origin
    dolt remote add docker_origin http://remote:50051/test-org/test-repo
    dolt config --local --add DOLT_READ_REPLICA_REMOTE docker_origin
}

cleanup() {
    kill $remotesrv_pid
}

setup
make_repos
cleanup
