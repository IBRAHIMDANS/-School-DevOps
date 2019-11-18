FROM golang:latest AS container_name
WORKDIR /go
ADD main.go .

RUN apk add upx
RUN CGO_ENABLED=0 go build -ldflags="-s -w" main.go
RUN upx main

FROM scratch
COPY --from=container_name /go /
EXPOSE 8080

ENTRYPOINT [ "/main"]
