 # Building

# Same Arch as system
cargo build --release
cargo run --release

# WASM build
cargo +beta build --release --target wasm32-wasi
cargo +beta run --release --target wasm32-wasi

# Linux buid with static musl
cargo build --release --target=x86_64-unknown-linux-musl

# Linux musl Docker build
docker build -t gtalk-presentation .
docker run --rm -p 8080:8080 -it gtalk-presentation