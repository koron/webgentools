FROM golang:alpine AS build-env
ENV GO111MODULE=on
RUN go get \
	github.com/go-swagger/go-swagger/cmd/swagger@v0.25.0 \
	github.com/golang/protobuf/protoc-gen-go@v1.4.2 \
	github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-gateway@v1.14.7 \
	github.com/grpc-ecosystem/grpc-gateway/protoc-gen-swagger@v1.14.7

FROM alpine:3.12.0
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
