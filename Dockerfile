FROM golang:1.26-alpine AS builder

WORKDIR /app

COPY . .

RUN apk update && \
    apk add ca-certificates && \
    go get ./... && \
    go build -C cmd \
        -o api .

FROM scratch AS runtime

COPY --from=builder /app/cmd/api api

EXPOSE 8000

ENTRYPOINT [ "/api" ]
