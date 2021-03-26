FROM golang:1.16.2-alpine3.13 as step1
WORKDIR /xxx
COPY . .
RUN go mod tidy
RUN go build -o api main.go

FROM alpine:latest  
RUN apk --no-cache add ca-certificates
WORKDIR /app/
COPY --from=step1 /xxx/api .
CMD ["./api"] 