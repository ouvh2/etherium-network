# Use a lightweight base image
FROM alpine:latest

# Install necessary dependencies
RUN apk add --no-cache \
    bash \
    curl \
    git \
    build-base \
    go

# Set the Go environment variables
ENV GOPATH /go
ENV GOROOT /usr/local/go
ENV PATH $GOROOT/bin:$GOPATH/bin:$PATH

# Install Go Ethereum (Geth)
RUN git clone https://github.com/ethereum/go-ethereum.git /go/src/github.com/ethereum/go-ethereum \
    && cd /go/src/github.com/ethereum/go-ethereum \
    && make geth

# Set up the working directory
WORKDIR /root

# Expose necessary ports
EXPOSE 8545 30303

# Copy the genesis.json file into the container
COPY genesis.json /root/genesis.json

# Initialize the Ethereum node with the genesis file (optional)
RUN /go/src/github.com/ethereum/go-ethereum/build/bin/geth --datadir /root/.ethereum init /root/genesis.json

# Set the default command to run the Ethereum node
CMD ["/go/src/github.com/ethereum/go-ethereum/build/bin/geth", "--networkid", "1234", "--datadir", "/root/.ethereum", "--http", "--http.addr", "0.0.0.0", "--http.port", "8545", "--http.corsdomain", "*", "--http.api", "web3,eth,net,personal,miner"]
