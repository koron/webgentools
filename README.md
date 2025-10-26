# webgentools

This project builds the docker image which includes tools:

* OS: Debian bookworm slim (20251020)
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

from GHCR

```console
$ docker pull ghcr.io/koron/webgentools:5.1.0
```

or Docker Hub

$ docker pull koron/webgentools:5.1.0

## How to build and release

Build with a `latest` tag:

```console
$ docker build -t koron/webgentools:latest .
```

Release is pushing a tag to github.
