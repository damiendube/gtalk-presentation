## Installing Deps

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup install stable
rustup target add wasm32-wasi
rustup target add x86_64-unknown-linux-musl

rustup install beta
rustup target add --toolchain beta wasm32-wasi
rustup target add --toolchain beta x86_64-unknown-linux-musl


rustup install nightly
rustup target add --toolchain nightly wasm32-wasi
rustup target add --toolchain nightly x86_64-unknown-linux-musl
```

# Building

## Same Arch as system

cargo build --release
cargo run --release

## WASM build

cargo +beta build --release --target wasm32-wasi
wasmer run target/wasm32-wasi/release/gtalk-presentation.wasm

## Linux buid with static musl

CC_x86_64_unknown_linux_musl="x86_64-linux-musl-gcc" cargo build --release --target=x86_64-unknown-linux-musl

## Linux musl Docker build

docker build -t gtalk-presentation .
docker run --rm -it gtalk-presentation

## Size Differences

docker images | grep gtalk && ls -lh target/release/gtalk-presentation target/x86_64-unknown-linux-musl/release/gtalk-presentation target/wasm32-wasi/release/gtalk-presentation.wasm