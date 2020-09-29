FROM golang:1.15 AS build
ENV CGO_ENABLED=0
ENV GOOS=linux
ENV GOARCH=amd64
ENV GOPATH=/go
RUN go get -d -u github.com/allanhung/vault-exporter 
WORKDIR /go/src/github.com/allanhung/vault-exporter
RUN go build -o vault-exporter main.go

FROM alpine:3.5
COPY --from=build /go/src/github.com/allanhung/vault-exporter/vault-exporter /usr/bin
ENTRYPOINT ["/usr/bin/vault-exporter"]
