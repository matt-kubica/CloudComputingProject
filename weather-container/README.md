Image available on [dockerhub](https://hub.docker.com/r/mkubica/ccds-weather-container).

### Building Image
```
docker build . -t mkubica/ccds-weather-container      
```

### Running Image
```
docker run -p 80:80 -d --name ccds-weather-container mkubica/ccds-weather-container
```
