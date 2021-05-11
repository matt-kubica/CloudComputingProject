Image available on [dockerhub](https://hub.docker.com/r/mkubica/ccdd-dummy-container).

### Building Image
```
docker build . -t mkubica/ccdd-dummy-container      
```

### Running Image
```
docker run -p 80:80 -d --name ccdd-dummy-container mkubica/ccdd-dummy-container
```
