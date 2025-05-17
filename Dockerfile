FROM rust:1.86.0

COPY . .

RUN cargo build --release

EXPOSE 9000

CMD ["./target/release/rust"]