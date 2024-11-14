docker image for circleci

# build command example
```
docker build . -t mediot/node:22.11.0-chrome-119.0.6045.105 -t mediot/node:latest
```

# push command example
```
docker push mediot/node:22.11.0-chrome-119.0.6045.105
docker push mediot/latest
```