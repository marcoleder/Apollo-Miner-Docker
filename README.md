# Apollo-Miner-Docker

Dockerization of the FutureBit Apollo BTC miner binaries.\
Please refer to [the original repository](https://github.com/jstefanop/Apollo-Miner-Binaries) for detailed instructions on how to configure the start script.\
This repository focuses on running the docker images on [Umbrel](https://umbrel.com/), hence only Linux binaries were kept.

## How to run
Create a new buildx builder instance to handle multiple platforms, create a new builder instance using the following command:

```bash
docker buildx create --name mybuilder --use
```

Initializing the new builder:

```bash
docker buildx inspect --bootstrap
```

For testing on an `amd64` platform, use the following command:

```bash
docker buildx build --platform linux/amd64 -t apollo-miner:latest --load .
```

Otherwise use the following command for `arm64`:

```bash
docker buildx build --platform linux/arm64 -t apollo-miner:latest --load .
```

Then, run your Docker container with your flags:

```bash
docker run apollo-miner:latest -host us-east.stratum.slushpool.com -port 3333 -user jstefanop.x -pswd x -comport /dev/ttyACM0 -brd_ocp 48 -osc 30 -ao_mode 1
```

## Flags
Docker run passes the following flags to the miner:
- `-host <pool address>`: The hostname or IP address of the mining pool's stratum. Example: `stratum.slushpool.com`.
- `-port <pool port>`: The port number for connecting to the pool's stratum. Example: `3333`.
- `-user <pool username/wallet>`: For most pools, this is the wallet address where you want your mining rewards sent. Some pools might require a username.
- `-pswd <pool password>`: The password for the pool. In many cases, this can be left empty. However, some pools with username-based authentication may require a password.
- `-comport <board port>`: The serial port name where your mining hardware is connected. On Linux, this usually appears as `/dev/ttyACM*` (e.g., `/dev/ttyACM0`, `/dev/ttyACM1`).
- `-brd_ocp <board power>`: This sets the power/voltage control for the board in percentage (%). The range is typically from 30-95%.
- `-osc <frequency>`: This sets the hashboard's operating frequency. The range is typically from 30-60.
