# Use a lightweight base image
FROM alpine:latest

# Install necessary dependencies
RUN apk add --no-cache \
    bash \
    curl \
    git \
    build-base \
    linux-headers \
    go

# Set the Go environment variables
ENV GOPATH=/go
ENV GOROOT=/usr/lib/go
ENV PATH=$GOROOT/bin:$GOPATH/bin:$PATH

RUN echo "GOROOT is $GOROOT" && \
    echo "GOPATH is $GOPATH"


# Install Go Ethereum (Geth)
RUN git clone https://github.com/ethereum/go-ethereum.git /go/src/github.com/ethereum/go-ethereum 
RUN cd /go/src/github.com/ethereum/go-ethereum 
RUN cd /go/src/github.com/ethereum/go-ethereum && make geth

# Set up the working directory
WORKDIR /root

# Expose necessary ports
EXPOSE 8545 30303

# Copy the genesis.json file into the container

# Initialize the Ethereum node with the genesis file (optional)

# Set the default command to run the Ethereum node
CMD ["/go/src/github.com/ethereum/go-ethereum/build/bin/geth","--rpcapi", "--networkid", "1234", "--datadir", "/root/.ethereum", "--http", "--http.addr", "0.0.0.0", "--http.port", "8545", "--http.corsdomain", "*","--rpcvhosts=*", "--http.api","web3,eth,net,personal,miner"]
