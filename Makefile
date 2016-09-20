all: rpib_freebsd amd64_freebsd amd64_darwin

create_build_dir:
	[ -d build/ ] || mkdir build/

build:
	docker run --rm -v "${PWD}":/usr/src/myapp -w /usr/src/myapp -e GOPATH=/usr -e GOOS=freebsd -e GOARCH=amd64 golang:1.6 /bin/bash -c "go get && go build -v"

run:
	docker run --rm -v "${PWD}":/usr/src/myapp -w /usr/src/myapp -e GOPATH=/usr golang:1.6 /bin/bash -c "go get && go run config.go main.go"

rpib_freebsd: create_build_dir
	docker run --rm -v "${PWD}":/usr/src/myapp -w /usr/src/myapp -e GOPATH=/usr -e GOOS=freebsd -e GOARCH=arm -e GOARM=6 golang:1.6 /bin/bash -c "go get && go build -v"
	mv myapp build/dyndns-rpib_freebsd

amd64_freebsd: create_build_dir
	docker run --rm -v "${PWD}":/usr/src/myapp -w /usr/src/myapp -e GOPATH=/usr -e GOOS=freebsd -e GOARCH=amd64 golang:1.6 /bin/bash -c "go get && go build -v"
	mv myapp build/dyndns-amd64_freebsd

amd64_darwin: create_build_dir
	docker run --rm -v "${PWD}":/usr/src/myapp -w /usr/src/myapp -e GOPATH=/usr -e GOOS=darwin -e GOARCH=amd64 golang:1.6 /bin/bash -c "go get && go build -v"
	mv myapp build/dyndns-amd64_freebsd
