# Build the manager binary
FROM golang:1.16 as builder

WORKDIR /workspace
# Copy the Go Modules manifests
# ENV GOPROXY=https://goproxy.cn,direct
COPY ./ .
# COPY go.sum go.sum
# cache deps before building and copying source so that we don't need to re-download as much
# and so that source changes don't invalidate our downloaded layer
RUN CGO_ENABLED=0 GO111MODULE=on go build -o main main.go

# Use distroless as minimal base image to package the manager binary
# Refer to https://github.com/GoogleContainerTools/distroless for more details
FROM alpine
WORKDIR /
COPY --from=builder /workspace/main /main
USER nonroot:nonroot

ENTRYPOINT ["/main"]