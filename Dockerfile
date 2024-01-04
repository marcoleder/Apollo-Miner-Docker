# Use Debian Slim Buster as the base image
FROM debian:bullseye-slim

# Set the working directory to /data/apollo-miner
WORKDIR /data/apollo-miner

# Copy everything to a temporary directory in the container
COPY . /tmp/build-context

# Define the target architecture using build arguments
ARG TARGETARCH

# Copy the appropriate files based on the architecture
RUN if [ "$TARGETARCH" = "arm64" ]; then \
        cp -r /tmp/build-context/linux-aarch64/* /data/apollo-miner/; \
    elif [ "$TARGETARCH" = "amd64" ]; then \
        cp -r /tmp/build-context/linux-x86_64/* /data/apollo-miner/; \
    fi

# Set the entrypoint script as the entry point
ENTRYPOINT ["./start_apollo.sh"]
