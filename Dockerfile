# Use the official Ethereum Geth image from Docker Hub
FROM ethereum/client-go:latest

# Expose RPC and P2P ports
EXPOSE 8545 30303 30303

# Configure entrypoint for Ethereum node
CMD ["geth", "--http", "--http.addr", "0.0.0.0", "--http.port", "8545", "--http.api", "eth,net,web3,admin", "--networkid", "1234", "--mine", "--miner.threads", "1"]
