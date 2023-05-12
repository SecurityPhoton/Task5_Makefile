APP_NAME=hello-world
CONTAINER_REGISTRY=quay.io

build:
	go build -o $(APP_NAME)

linux:
	GOOS=linux GOARCH=amd64 go build -o $(APP_NAME)_linux_amd64
	docker build . -t ${CONTAINER_REGISTRY}/${APP_NAME}:linux-amd64

arm:
	GOOS=linux GOARCH=arm GOARM=7 go build -o $(APP_NAME)_linux_armv7
	docker build . -t ${CONTAINER_REGISTRY}/${APP_NAME}:linux_armv7

macos:
	GOOS=darwin GOARCH=amd64 go build -o $(APP_NAME)_darwin_amd64
	docker build . -t ${CONTAINER_REGISTRY}/${APP_NAME}:darwin_amd64

windows:
	GOOS=windows GOARCH=amd64 go build -o $(APP_NAME)_windows_amd64.exe
	docker build . -t ${CONTAINER_REGISTRY}/${APP_NAME}:windows_amd64.exe

image:
  docker build . -t ${CONTAINER_REGISTRY}/${APP_NAME}

clean:
	docker rmi $(CONTAINER_REGISTRY)/$(APP_NAME):linux-amd64
	docker rmi $(CONTAINER_REGISTRY)/$(APP_NAME):linux-armv7
	docker rmi $(CONTAINER_REGISTRY)/$(APP_NAME):darwin-amd64
	docker rmi $(CONTAINER_REGISTRY)/$(APP_NAME):windows-amd64
