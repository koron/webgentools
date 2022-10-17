NAME=koron/webgentools
TAG?=$(shell git describe --candidate=0)

build:
	docker buildx build --platform=linux/amd64,linux/arm64 -t $(NAME):latest .

build-tag:
	docker buildx build --platform=linux/amd64,linux/arm64 -t $(NAME):$(TAG) .

push:
	docker buildx build --platform=linux/amd64,linux/arm64 -t $(NAME):latest --push .

push-tag:
	docker buildx build --platform=linux/amd64,linux/arm64 -t $(NAME):$(TAG) --push .

release:
	docker build -t $(NAME):$(TAG) .
	docker push $(NAME):$(TAG)
	docker tag $(NAME):$(TAG) $(NAME):latest
	docker push $(NAME):latest
