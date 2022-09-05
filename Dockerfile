FROM golang:1.19.0-bullseye AS build-env
ARG PROTOC_VER="21.5"
ARG GRPCGW_VER="2.11.3"
ADD https://github.com/protocolbuffers/protobuf/releases/download/v${PROTOC_VER}/protoc-${PROTOC_VER}-linux-x86_64.zip /go/
RUN apt update -y && \
	apt install -y --no-install-recommends \
          unzip && \
	apt clean && \
	rm -rf /var/lib/apt/lists/*
RUN unzip -q protoc-${PROTOC_VER}-linux-x86_64.zip
RUN go install github.com/go-swagger/go-swagger/cmd/swagger@v0.30.2
RUN go install google.golang.org/protobuf/cmd/protoc-gen-go@v1.28.1
RUN go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@v1.2.0
RUN go install \
	github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-grpc-gateway@v${GRPCGW_VER} \
	github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-openapiv2@v${GRPCGW_VER}

FROM debian:bullseye-20220822-slim
RUN mkdir -p /root/go
RUN apt update -y && \
	apt install -y --no-install-recommends \
          make && \
	apt clean && \
	rm -rf /var/lib/apt/lists/*
COPY --from=build-env \
	/go/bin/protoc \
	/go/bin/swagger \
	/go/bin/protoc-gen-go \
	/go/bin/protoc-gen-go-grpc \
	/go/bin/protoc-gen-grpc-gateway \
	/go/bin/protoc-gen-openapiv2 \
	/usr/local/bin/
COPY --from=build-env \
	/go/include \
	/usr/local/include
