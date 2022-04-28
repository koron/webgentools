FROM golang:1.18.1-bullseye AS build-env
ADD https://github.com/protocolbuffers/protobuf/releases/download/v3.15.8/protoc-3.15.8-linux-x86_64.zip /go/
RUN apt update -y && \
	apt install -y --no-install-recommends \
          unzip && \
	apt clean && \
	rm -rf /var/lib/apt/lists/*
RUN unzip -q protoc-3.15.8-linux-x86_64.zip
RUN go install github.com/go-swagger/go-swagger/cmd/swagger@v0.29.0
RUN go install google.golang.org/protobuf/cmd/protoc-gen-go@v1.28.0
RUN go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@v1.2.0
RUN go install \
	github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-grpc-gateway@v2.3.0 \
	github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-openapiv2@v2.3.0

FROM debian:bullseye-20220418-slim
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
