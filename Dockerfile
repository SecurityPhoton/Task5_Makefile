FROM quay.io/projectquay/golang:1.20 AS builder

COPY . /app

WORKDIR /app

ARG TARGETOS
ARG TARGETARCH
RUN CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -o myapp

FROM scratch

COPY --from=builder /app/myapp /myapp

ENTRYPOINT ["/myapp"]
