# ------------------------------------------------------------------------------
# Cargo Build Stage
# ------------------------------------------------------------------------------

FROM rust:latest as cargo-build

RUN apt-get update

RUN apt-get install musl-tools -y

RUN rustup target add x86_64-unknown-linux-musl

WORKDIR /usr/src/gtalk-presentation

COPY Cargo.toml Cargo.toml

RUN mkdir src/

RUN echo "fn main() {println!(\"if you see this, the build broke\")}" > src/main.rs

RUN RUSTFLAGS=-Clinker=musl-gcc cargo build --release --target=x86_64-unknown-linux-musl

RUN rm -f target/x86_64-unknown-linux-musl/release/deps/gtalk-presentation*

COPY . .

RUN RUSTFLAGS=-Clinker=musl-gcc cargo build --release --target=x86_64-unknown-linux-musl

# ------------------------------------------------------------------------------
# Final Stage
# ------------------------------------------------------------------------------

FROM alpine:latest

RUN addgroup -g 1000 gtalk-presentation

RUN adduser -D -s /bin/sh -u 1000 -G gtalk-presentation gtalk-presentation

WORKDIR /home/gtalk-presentation/bin/

COPY --from=cargo-build /usr/src/gtalk-presentation/target/x86_64-unknown-linux-musl/release/gtalk-presentation .

RUN chown gtalk-presentation:gtalk-presentation gtalk-presentation

USER gtalk-presentation

EXPOSE 8080

CMD ["./gtalk-presentation"]