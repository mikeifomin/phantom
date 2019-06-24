FROM golang:1.12 as compiler

WORKDIR /app
COPY . .

#RUN go build -mod=vendor -o /bin/phantom cmd/server/main.go
RUN go build -o /bin/phantom cmd/phantom/main.go

FROM debian:buster
RUN apt-get update && apt-get install -y ca-certificates
COPY --from=compiler /bin/phantom /bin/phantom
COPY configs /configs
ENTRYPOINT ["bin/phantom"]
