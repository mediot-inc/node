docker image for circleci

# build command
```
docker build . -t mediot/node:<node version>-chrome-<chrome version>-<build version> -t mediot/node:latest
```
## example
```
docker build . -t mediot/node:22.22.0-chrome-119.0.6045.105-0.0.1 -t mediot/node:latest
```

# push command example
```
docker push mediot/node:22.22.0-chrome-119.0.6045.105-0.0.1
docker push mediot/node:latest
```