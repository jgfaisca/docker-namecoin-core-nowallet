# docker-namecoind-core-no-wallet
Automated dockerhub build for namecoin-core, a reimplementation of Namecoin on top of the current Bitcoin Core codebase. 
When the intention is to run a P2P node without a wallet.

### RUN
$ ./create-docker-network.sh <br>
$ ./build_local.sh <br>
$ ./run-namecoin-docker.sh nmc-node 10.17.0.3<br>

### LOG
$ docker logs -f nmc-node  

### TEST
$ docker exec -it 'nmc-node' 

### SHELL CONSOLE
$ docker exec -it 'nmc-node' bash
