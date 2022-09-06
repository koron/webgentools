FROM golang:1.19.0-bullseye AS build-env
ARG PROTOC_VER="21.5"
ARG SWAGGER_VER="v0.30.2"
ARG PROTOC_GO_VER="v1.28.1"
ARG PROTOC_GO_GRPC_VER="v1.2.0"
ARG GRPCGW_VER="v2.11.3"
ARG JSON2YAML_VER="v0.0.0-20200315134601-cf69c935700d"
ADD https://github.com/protocolbuffers/protobuf/releases/download/v${PROTOC_VER}/protoc-${PROTOC_VER}-linux-x86_64.zip /go/
RUN apt update -y && \
	apt install -y --no-install-recommends \
          unzip && \
	apt clean && \
	rm -rf /var/lib/apt/lists/*
RUN unzip -q protoc-${PROTOC_VER}-linux-x86_64.zip
RUN go install github.com/go-swagger/go-swagger/cmd/swagger@${SWAGGER_VER}
RUN go install google.golang.org/protobuf/cmd/protoc-gen-go@${PROTOC_GO_VER}
RUN go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@${PROTOC_GO_GRPC_VER}
RUN go install \
	github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-grpc-gateway@${GRPCGW_VER} \
	github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-openapiv2@${GRPCGW_VER}
RUN go install github.com/bronze1man/json2yaml@${JSON2YAML_VER}

FROM debian:bullseye-20220822-slim AS go-extract
ADD https://go.dev/dl/go1.19.linux-amd64.tar.gz /opt/go.tar.gz
RUN cd /opt && tar xzf go.tar.gz && rm -f go.tar.gz

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
	/go/bin/json2yaml \
	/usr/local/bin/
COPY --from=build-env \
	/go/include \
	/usr/local/include
COPY --from=go-extract /opt/go /opt/go
ENV PATH $PATH:/opt/go/bin
