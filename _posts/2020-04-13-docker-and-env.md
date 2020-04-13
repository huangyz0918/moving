---
layout: post
title: "Docker and ENV"
categories: docker 
---

Have you ever been in trouble with `ENV` when working with `Docker`? With me, yah, obviously, I've been if don't want to say `a lot`

When you work with `Docker` you may realize that we have two phrases: building time and runtime. 
- buiding time: when you run `$ docker build ...` in your favorite terminal. Docker will build your `Dockerfile` into an Docker image.
- runtime: when you run `$ docker run`. Docker will run a container by your built image and you can interact with it as a real computer.

## ARG ?
Imagine that you want to build fancy website as below:

```go
// main.go
package main

func handler(w http.ResponseWriter, req *http.Request) {
    fmt.Fprintf(w, "I'm running on port: %s", os.Getenv("PORT"))
}

func main() {
    http.HandleFunc("/", handler)
    log.Fatal(http.ListenAndServe(":" + os.Getenv("PORT"), nil))
}
```

and our Dockerfile

```dockerfile
# Builder
FROM golang:1.14.2-alpine as builder
  
WORKDIR /go/src/
COPY main.go .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app .
 
# Release 
FROM alpine:latest as release

ARG PORT

WORKDIR /root/
COPY --from=builder /go/src/app .

EXPOSE $PORT
CMD ["./app"]
```

First of all, we we need our container can talk to outsite world, we need to `EXPOSE` a port from it and the port should be define as an `ARG` for changing.

After define everything, we can build our image

```bash
$ docker build --target release -t blog-examples:release --build-arg PORT=8080 .
$ docker run blog-examples:release
```

and verify:

```bash
$ docker ps
CONTAINER ID        IMAGE                   COMMAND                  CREATED             STATUS              PORTS                    NAMES
54d32460c436        blog-examples:release   "./app"                  4 minutes ago       Up 4 minutes        8080/tcp                 affectionate_bhaskara
```
Yeah, we successfully expose our container to the world through an variable port instead of hard-coded one.

But, I want to use my $PORT from my computer instead of passing `8080`. Just change a little bit on your build command
```shell
$ docker build --target release -t blog:examples:release --build-arg PORT=$PORT .
```

But, we also need to add ENV variable to our container as well? We need it when we run `os.Getenv("PORT")`, right?

## ENV ?

We're gonna modify our Dockerfile a little bit.

```dockerfile
# ...
ARG PORT

ENV PORT=$PORT

# ...
EXPOSE $PORT
# ...
```

Build it again
```bash
$ docker build --target release --build-arg PORT=$PORT -t blog-examples:release .
$ docker run -p $PORT:$PORT -t blog-examples:release
```

Verify it:
```bash
$ curl localhost:$PORT
I'm running on port: 8080% 
```

## --env-file? 
How about when we have a lot of ENV and we don't want to add an ARG for each ENV we use, right?

Let's modify our website a little bit:

```go
func handler(w http.ResponseWriter, req *http.Request) {
    fmt.Fprintf(w, "I'm running on port: %s, and APP_SECRET=%s", os.Getenv("PORT"), os.Getenv("APP_SECRET"))
}
```

- Add `.env` file:
```bash
PORT=8080
APP_SECRET=abcdefghijklmnopqrstuvwxyz
```

Build and run:
```bash
$ docker build --target release --build-arg PORT=$PORT blog-examples:release .
$ docker run -p $PORT:$PORT --env-file .env blog-examples:release
```

Verify it:
```bash
$ curl localhost:$PORT
I'm running on port: 8080, and APP_SECRET=abcdefghijklmnopqrstuvwxyz% 
```

So, we can feed ENV to container by `--env-file`

And don't forget to add `.env` file to `.gitignore`, you don't want to show sensitive data on any public repository

## docker-compose?

```yml
version: '3.4'

services:
    web:
        build:
            context: .
            target: release
            args:
                - PORT
        environment:
            - APP_SECRET
        ports:
            - $PORT:$PORT
```

With `docker-compose` we can build properly without `--build-arg` or `--env-file`

Additionally, we can view built docker-compose by
```bash
docker-compose config
```




