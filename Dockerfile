FROM golang:alpine

# Set necessary environmet variables needed for our image
ENV GO111MODULE=on \
    CGO_ENABLED=0 \
    GOOS=linux \
    GOARCH=amd64
	
ENV OUTPUT_PATH=/app/Result.txt

# Move to working directory /build
WORKDIR /build

# Copy and download dependency using go mod
COPY go.mod .
COPY go.sum .
# COPY inputfile /build/
RUN go mod download

# Copy the code into the container
COPY . .

# Build the application
RUN go build -o main .

# Move to /dist directory as the place for resulting binary folder
WORKDIR /app

# Copy binary from build to main folder
RUN cp /build/main .

# Command to run when starting the container
CMD ["/app/main"]