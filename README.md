# Open Data Cube Docker Images

This is the official repository of the ODC Docker images in Brazil Data Cube. 

## Build images

```shell
./build.sh
```

The above command will create the following images:

```shell
docker image ls | grep odc
```

```
bdc/odc-stats     1.8        25951364cd2c   3 hours ago     8.84GB
bdc/odc           1.8        a5c9778fc15e   4 hours ago     8.28GB
```

## Running Containers

After the build of the images, they are ready to be used. Below is an example of the use of each of the defined images. Note that depending on the way the images were created, the commands below may undergo minor changes.

**UNDER DEVELOPMENT**