FROM golang:alpine AS build-env
ENV GO111MODULE=on
RUN go get \
	github.com/go-swagger/go-swagger/cmd/swagger@6d41a965 \
	github.com/golang/protobuf/protoc-gen-go@v1.3.2 \
	github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-gateway@v1.11.3 \
	github.com/grpc-ecosystem/grpc-gateway/protoc-gen-swagger@v1.11.3

FROM alpine:3.10.2
RUN apk add --no-cache \
	ca-certificates \
	make \
	protobuf \
	protobuf-dev
COPY --from=build-env \
	/go/bin/swagger \
	/go/bin/protoc-gen-go \
	/go/bin/protoc-gen-grpc-gateway \
	/go/bin/protoc-gen-swagger \
	/usr/local/bin/
