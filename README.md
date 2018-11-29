# Goofys Mount Minio From Container

The repository provides a Docker wrapper for using goofys to mount any S3 compatible
object store in a container.

## Usage

```bash
docker run --privileged -it --rm --name goofys \
    -e ENDPOINT=<endpoint> \
    -e BUCKET=<name-of-bucket> \
    -e AWS_ACCESS_KEY_ID=<access-key> \
    -e AWS_SECRET_ACCESS_KEY=<secret-key>
    goofys
```
