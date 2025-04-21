FROM golang:1.22.5 as base
WORKDIR /app

COPY go.mod .

RUN go mod download

COPY . .

RUN go build -o main .

# Stage 2: Build the final image
FROM gcr.io/distroless/base

COPY --from=base /app/main .

COPY --from=base /app/static ./static

EXPOSE 8081

CMD ["/main"]
# This Dockerfile is for a Go web application. It uses a multi-stage build to create a lightweight final image.
