# Cross-compile for aarch64 (Ubuntu) for Raspberry Pi 3 and 4.

Commands:
```shell
docker build --pull --no-cache . -t spotifyd-aarch64
docker run --name spotifyd-aarch64 spotifyd-aarch64:latest
docker cp spotifyd-aarch64:/root/spotifyd/target/aarch64-unknown-linux-gnu/release/spotifyd .
docker stop spotifyd-aarch64
docker system prune -af
```
