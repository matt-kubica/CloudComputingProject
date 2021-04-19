### Building Image

```
docker build . -t ccdd/dummy-container      
```

### Running Image
```
docker run -p 3000:3000 -d --name dummy-container ccdd/dummy-container
```
