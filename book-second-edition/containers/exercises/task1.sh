docker run -p 8080:8080 nodejs-hello-world:1.0.0 # maps exposed port of 8080 to host's 8080
# in an separate terminal window
curl localhost:8080/
docker logs <container_id>