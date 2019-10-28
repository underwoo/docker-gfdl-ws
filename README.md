# GFDL Workstation Docker Container

# Building the image

```
docker build -t underwoo/gfdl-ws
```

# Running the image

```
docker run -t -d \
    --hostname ldc000001.gfdl.noaa.gov \
    underwoo/gfdl-ws
```
