# webgentools

This project builds the docker image which includes tools:

* OS: Debian bullseye slim (20250317)
* Tools:
    * swagger ([github.com/go-swagger/go-swagger][go-swagger])
    * protoc ([protobuf:v30.1][protobuf]) - from [protobuf/releases][protobuf-releases]
    * protoc-gen-go ([github.com/golang/protobuf][proto-gen-go])
    * protoc-gen-go-grpc (https://github.com/grpc/grpc-go)
    * proto-gen-grpc-gateway ([github.com/grpc-ecosystem/grpc-gateway][grpc-gateway])
    * proto-gen-swagger ([github.com/grpc-ecosystem/grpc-gateway][grpc-gateway])

[go-swagger]:https://github.com/go-swagger/go-swagger
[protobuf]:https://github.com/protocolbuffers/protobuf/releases/tag/v30.1
[protobuf-releases]:https://github.com/protocolbuffers/protobuf/releases
[proto-gen-go]:https://github.com/protocolbuffers/protobuf-go
[grpc-gateway]:https://github.com/grpc-ecosystem/grpc-gateway

## How to pull latest image

```console
$ docker pull ghcr.io/koron/webgentools:5.0.0
```

## How to build and release

Build:

```console
# Build with name "koron/webgentools:latest"
$ make build
```

Release:

*   release by tags
    1. create a tag to release
    2. push the tag
*   release as "latest"
    1. push to "main" branch
