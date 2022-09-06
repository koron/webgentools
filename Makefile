NAME=koron/webgentools
TAG?=$(shell git describe --candidate=0)

build:
	docker build -t $(NAME):latest .

build-tag:
	docker build -t $(NAME):$(TAG) .

push:
	docker push $(NAME):latest

push-tag:
	docker push $(NAME):$(TAG)

release:
	docker build -t $(NAME):$(TAG) .
	docker push $(NAME):$(TAG)
	docker tag $(NAME):$(TAG) $(NAME):latest
	docker push $(NAME):latest
