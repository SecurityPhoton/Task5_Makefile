# Змінні для налаштування збірки
BINARY_NAME := myapp
BUILD_DIR := build
IMAGE_REGISTRY := ghcr.io
IMAGE_NAMESPACE := pontarr
IMAGE_NAME := myapp
IMAGE_TAG := latest

format:
	gofmt -s -w ./

lint:
	golint

test:
	go test -v

get: 
	go get


build: format get
	CGO_ENABLED=0 go build -v -o $(BINARY_NAME) main.go

# Збирання коду для Linux
linux: export GOOS=linux
linux: export GOARCH=amd64
linux: build
    

# Збирання коду для ARM
arm: export GOOS=linux
arm: export GOARCH=arm
arm: export GOARM=7
arm: build

# Збирання коду для macOS
macos: export GOOS=darwin
macos: export GOARCH=amd64
macos: build

# Збирання коду для Windows
windows: export GOOS=windows
windows: export GOARCH=amd64
windows: build



# Видалення створеного образу Docker
clean: docker-build
	docker rmi $(IMAGE_REGISTRY)/$(IMAGE_NAMESPACE)/$(IMAGE_NAME):$(IMAGE_TAG) || true

# Збирання Docker-образу
docker-build:
	docker build -t $(IMAGE_REGISTRY)/$(IMAGE_NAMESPACE)/$(IMAGE_NAME):$(IMAGE_TAG) .

# Публікація Docker-образу в реєстрі
docker-publish:
	docker push $(IMAGE_REGISTRY)/$(IMAGE_NAMESPACE)/$(IMAGE_NAME):$(IMAGE_TAG)