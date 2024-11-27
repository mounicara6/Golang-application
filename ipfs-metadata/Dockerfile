# Use a lightweight Golang base image for building
FROM golang:1.20-alpine as builder

# Set the working directory
WORKDIR /app

# Copy go.mod and go.sum
COPY go.mod go.sum ./

# Download dependencies
RUN go mod download

# Copy the application code
COPY . .

# Build the application
RUN go build -o main .

# Ensure the binary has executable permissions in the builder stage
RUN chmod +x /app/main

# Use a minimal image for production
FROM alpine:latest

WORKDIR /root/

# Copy the compiled binary from the builder stage
COPY --from=builder /app/main .

# Ensure the binary is owned by the non-root user and group
RUN chown 1000:1000 /root/main

# Add a non-root user for security
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser

# Expose the port the application runs on
EXPOSE 8080

# Run the application
CMD ["./main"]
