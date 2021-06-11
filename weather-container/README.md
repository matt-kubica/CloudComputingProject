Image available on [dockerhub](https://hub.docker.com/r/mkubica/ccds-dummy-container).

### Building Image
```
docker build . -t mkubica/ccds-dummy-container      
```

### Running Image
```
docker run -p 80:80 -d --name ccds-dummy-container mkubica/ccds-dummy-container
```
