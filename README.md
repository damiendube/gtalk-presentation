# README

## Installing Deps

```bash
# Install Rustup
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
# Install stable toolchain
rustup install stable
# Install none-default targets
rustup target add wasm32-wasi
rustup target add x86_64-unknown-linux-musl
```

## Building

### Same Arch as system

cargo build --release
cargo run --release

### WASM build

cargo build --release --target wasm32-wasi
wasmer run target/wasm32-wasi/release/gtalk-presentation.wasm

### Linux buid with static musl

CC_x86_64_unknown_linux_musl="x86_64-linux-musl-gcc" cargo build --release --target=x86_64-unknown-linux-musl

### Linux musl Docker build

docker build -t gtalk-presentation .
docker run --rm -it gtalk-presentation

## Size Differences

docker images | grep gtalk && ls -lh target/release/gtalk-presentation target/x86_64-unknown-linux-musl/release/gtalk-presentation target/wasm32-wasi/release/gtalk-presentation.wasm
