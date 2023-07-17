## Build stage
FROM golang:1.20.6-alpine AS build-env
ADD ./main.go /go/src/github.com/willamssouza/rtsp-stream/main.go
ADD ./core /go/src/github.com/willamssouza/rtsp-stream/core
ADD ./Gopkg.toml /go/src/github.com/willamssouza/rtsp-stream/Gopkg.toml
WORKDIR /go/src/github.com/willamssouza/rtsp-stream
RUN apk add --update --no-cache git
RUN go mod init github.com/willamssouza/rtsp-stream
RUN go mod tidy
RUN go build -o server

## Creating potential production image
FROM alpine
RUN apk update && apk add bash ca-certificates ffmpeg && rm -rf /var/cache/apk/*
WORKDIR /app
COPY --from=build-env /go/src/github.com/willamssouza/rtsp-stream/server /app/
COPY ./build/rtsp-stream.yml /app/rtsp-stream.yml
ENTRYPOINT [ "/app/server" ]
