# webgentools

This project builds the docker image which includes tools:

* OS: Apline 3.13.1
* Tools:
    * swagger ([github.com/go-swagger/go-swagger][go-swagger])
    * protoc ([protobuf:v3.13.0][protobuf]) - from [Alpine's repository][alpine-protobuf].
    * protoc-gen-go ([github.com/golang/protobuf][proto-gen-go])
    * proto-gen-grpc-gateway ([github.com/grpc-ecosystem/grpc-gateway][grpc-gateway])
    * proto-gen-swagger ([github.com/grpc-ecosystem/grpc-gateway][grpc-gateway])

[go-swagger]:https://github.com/go-swagger/go-swagger
[protobuf]:https://github.com/protocolbuffers/protobuf/releases/tag/v3.13.0
[alpine-protobuf]:https://pkgs.alpinelinux.org/packages?name=protobuf&branch=v3.13
[proto-gen-go]:https://github.com/protocolbuffers/protobuf-go
[grpc-gateway]:https://github.com/grpc-ecosystem/grpc-gateway
