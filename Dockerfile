FROM golang:alpine as build-stage

RUN apk add --no-cache -u git ca-certificates gcc musl-dev
RUN CGO_ENABLED=0 go get github.com/kahing/goofys && \
    go build -o /app/goofys github.com/kahing/goofys

FROM alpine 

# add syslog-ng (syslog required by Goofys)
RUN apk add --no-cache -u fuse syslog-ng ca-certificates
COPY syslog-ng.conf /etc/syslog-ng/syslog-ng.conf

# Copy binary
COPY --from=build-stage /app/goofys /usr/bin/goofys
COPY run.sh /root/run.sh

ENTRYPOINT [ "/root/run.sh" ]
