# docker-namecoind-core-no-wallet
Automated dockerhub build for namecoin-core compiled in disable-wallet mode, a reimplementation of Namecoin on top of the current Bitcoin Core codebase. When the intention is to run a P2P namecoin node without a wallet.


### NETWORK
$ ./create-docker-network.sh 

### IMAGE
$ ./build_local.sh 

### RUN
$ ./run-namecoin-docker.sh nmc-node 10.17.0.2

### LOG
$ docker logs -f nmc-node  

### TEST
#### Version
$ docker exec -it 'nmc-node' namecoin-cli -version
#### Information
$ docker exec -it 'nmc-node' namecoin-cli -datadir=/data/namecoin -getinfo

### CONSOLE
$ docker exec -it 'nmc-node' bash
