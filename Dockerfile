FROM rust:alpine as builder

RUN apk add musl-dev
WORKDIR /builder
COPY . .

RUN RUSTFLAGS="-C link-args=-s" cargo build --release

FROM alpine:latest

COPY public public
WORKDIR /app
COPY --from=builder /builder/target/release/privacy-policy privacy-policy

LABEL org.opencontainers.image.authors "nagara Network Developers <dev@nagara.network>"
LABEL org.opencontainers.image.source "https://github.com/nagara-network/privacy-policy"
LABEL org.opencontainers.image.description "nagara Network - Privacy Policy"

ENTRYPOINT [ "/app/privacy-policy" ]
