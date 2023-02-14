FROM ubuntu:latest

# Setup GDAL
RUN apt-get update
RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:ubuntugis/ubuntugis-unstable
RUN apt-get install -y \
	llvm-dev \
	libclang-dev \
	clang \
	build-essential \
	curl \
	gdal-bin \
	libgdal-dev 


# Install Rust
RUN curl https://sh.rustup.rs -sSf | bash -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

# Build app
WORKDIR /app
COPY . .
RUN cargo build --release

# Cleanup
RUN rm -rf ./src

# Start app
CMD ["./target/release/rust_gdal_docker"]
