# Our base image is Alpine Linux 3.4.
FROM alpine:3.4

# Set up the environment for building the application.
ENV GOROOT=/usr/lib/go \
    GOPATH=/opt/hello-go \
    PATH=$PATH:$GOROOT/bin:$GOPATH

# Establish a working directory and copy our application
# files into it.
WORKDIR /opt/hello-go
ADD . /opt/hello-go

# Build your application.
RUN \
	# Upgrade old packages.
	apk --update upgrade && \
	# Ensure we have ca-certs installed.
	apk add --no-cache ca-certificates && \
	# Install go for building.
	apk add -U go && \
	# Compile our app
	go build hello.go && \
	# Delete go after build.
	apk del go

# Run the application.
ENTRYPOINT ["/opt/hello-go/hello"]

# You can test this Docker image locally by running:
#
#    $ docker build -t hello-go .
#    $ docker run --rm -it --expose 8081 -p 8081:8081 -e PORT=8081 hello-go
#
# and then visiting http://localhost:8081/ in your browser.