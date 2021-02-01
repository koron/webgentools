FROM golang:1.16rc1-alpine3.13 AS build-env
ENV GO111MODULE=on
RUN go install github.com/go-swagger/go-swagger/cmd/swagger@v0.26.0
RUN go install google.golang.org/protobuf/cmd/protoc-gen-go@v1.25.0
RUN go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@v1.1.0
RUN go install \
	github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-gateway@v1.16.0 \
	github.com/grpc-ecosystem/grpc-gateway/protoc-gen-swagger@v1.16.0

FROM alpine:3.13.1
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
