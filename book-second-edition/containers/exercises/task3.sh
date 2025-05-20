docker pull alpine:3.18.2
docker save -o alpine-3.18.2.tar alpine:3.18.2
docker image rm alpine
docker load --input alpine-3.18.2.tar
docker image ls