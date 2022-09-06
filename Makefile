NAME=koron/webgentools
TAG=$(shell git describe)

build:
	docker build -t $(NAME):latest .

build-tag:
	docker build -t $(NAME):$(TAG) .

push:
	docker push $(NAME):latest

push-tag:
	docker push $(NAME):$(TAG)

release:
	docker build -t $(NAME):latest .
	docker tag $(NAME):latest $(NAME):$(TAG)
	docker push $(NAME):$(TAG)
	docker push $(NAME):latest
