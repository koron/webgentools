ARG PROTOC_VER="30.1"
ARG GRPCGW_VER="2.26.3"

FROM golang:1.24.1-bullseye AS build-env
ARG GRPCGW_VER
RUN go install golang.org/x/tools/cmd/goimports@v0.31.0
RUN go install github.com/go-swagger/go-swagger/cmd/swagger@v0.31.0
RUN go install google.golang.org/protobuf/cmd/protoc-gen-go@v1.36.6
RUN go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@v1.5.1
RUN go install \
	github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-grpc-gateway@v${GRPCGW_VER} \
	github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-openapiv2@v${GRPCGW_VER}
RUN go install github.com/koron/tmpl/cmd/tmpl@v0.1.0
RUN go install github.com/bronze1man/json2yaml@v0.0.0-20200315134601-cf69c935700d

FROM debian:bullseye-20250317-slim AS protoc-extract
ARG TARGETARCH
ARG PROTOC_VER
WORKDIR /opt
COPY arch.sh .
RUN ./arch.sh
RUN apt update -y && \
	apt install -y --no-install-recommends \
          ca-certificates \
          curl \
          unzip && \
	apt clean && \
	rm -rf /var/lib/apt/lists/*
RUN curl -fssL https://github.com/protocolbuffers/protobuf/releases/download/v${PROTOC_VER}/protoc-${PROTOC_VER}-linux-$(cat /.protoc_arch).zip -o protoc-linux.zip
RUN unzip -q protoc-linux.zip

FROM debian:bullseye-20250317-slim AS go-extract
ARG TARGETARCH
ADD https://go.dev/dl/go1.24.1.linux-${TARGETARCH}.tar.gz /opt/go.tar.gz
RUN cd /opt && tar xzf go.tar.gz && rm -f go.tar.gz

FROM debian:bullseye-20250317-slim
RUN mkdir -p /root/go
RUN apt update -y && \
	apt install -y --no-install-recommends \
          make && \
	apt clean && \
	rm -rf /var/lib/apt/lists/*
COPY --from=build-env \
	/go/bin/goimports \
	/go/bin/swagger \
	/go/bin/protoc-gen-go \
	/go/bin/protoc-gen-go-grpc \
	/go/bin/protoc-gen-grpc-gateway \
	/go/bin/protoc-gen-openapiv2 \
	/go/bin/tmpl \
	/go/bin/json2yaml \
	/usr/local/bin/
COPY --from=protoc-extract \
	/opt/bin/protoc \
	/usr/local/bin
COPY --from=protoc-extract \
	/opt/include \
	/usr/local/include
COPY --from=go-extract /opt/go /opt/go
ENV PATH=$PATH:/opt/go/bin
