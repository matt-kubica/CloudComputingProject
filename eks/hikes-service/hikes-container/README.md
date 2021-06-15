Image available on [dockerhub](https://hub.docker.com/r/mkubica/ccds-hikes-container).

### Building Image
```
docker build . -t mkubica/ccds-hikes-container      
```

### Running Image
```
docker run -p 80:80 -d --name ccds-hikes-container mkubica/ccds-hikes-container
```
