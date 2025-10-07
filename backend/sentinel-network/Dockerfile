# --- Estágio de Build ---
FROM golang:1.21-alpine AS builder
WORKDIR /app
COPY go.mod ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o sentinel .
# --- Estágio Final ---
FROM alpine:latest
WORKDIR /root/
COPY --from=builder /app/sentinel .
EXPOSE 8081
CMD ["./sentinel"]
