# Use the official Ethereum Geth image from Docker Hub
FROM ethereum/client-go:latest

# Expose RPC and P2P ports
EXPOSE 8545 30303 30303

# Configure entrypoint for Ethereum node
COPY genesis.json /genesis.json
CMD ["--networkid", "1234", "--datadir", "/root/.ethereum", "--http", "--http.addr", "0.0.0.0", "--http.port", "8545","--rpc-http-cors-origins", "*","--http.api", "web3,eth,net,personal,miner"]
