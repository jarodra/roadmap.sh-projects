# [Basic Dockerfile](https://roadmap.sh/projects/basic-dockerfile)
Build a basic Dockerfile to create a Docker image.

In this project, you will write a basic Dockerfile to create a Docker image. When this Docker image is run, it should print “Hello, Captain!” to the console before exiting.

## Requirements
The Dockerfile should be named Dockerfile.
The Dockerfile should be in the root directory of the project.
The base image should be alpine:latest.
The Dockerfile should contain a single instruction to print “Hello, Captain!” to the console before exiting.

If you are looking to build a more advanced version of this project, you can consider adding the ability to pass your name to the Docker image as an argument, and have the Docker image print “Hello, [your name]!” instead of “Hello, Captain!”.

## Solution
1. **Build the Docker image** with the build argument (if build-arg is not specified it will default to Captain): 

    `docker build --tag "dockerfile-basic" --build-arg MY_NAME=Bob .`

2. **Run the container**: 

    `docker build --tag "dockerfile-basic" .`