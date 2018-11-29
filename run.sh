#!/bin/sh

# Check arguments
if [ -z "${AWS_ACCESS_KEY_ID}" ]; then
    echo "Specify AWS_ACCESS_KEY_ID" ; exit 1
fi
if [ -z "${AWS_SECRET_ACCESS_KEY}" ]; then
    echo "Specify AWS_SECRET_ACCESS_KEY" ; exit 1
fi
if [ -z "${ENDPOINT}" ]; then
    echo "Specify ENDPOINT" ; exit 1
fi
if [ -z "${BUCKET}" ]; then
    echo "Specify BUCKET" ; exit 1
fi

# Run syslog-ng
syslog-ng

# Build credentials file
mkdir -p /root/.aws/ /mnt/s3
chmod 700 /root/.aws
cat - > /root/.aws/credentials <<CREDENTIALS
[default]
aws_access_key_id = ${AWS_ACCESS_KEY_ID}
aws_secret_access_key = ${AWS_SECRET_ACCESS_KEY}
CREDENTIALS

# Run goofys
goofys -o allow_other -f --endpoint=${ENDPOINT} ${BUCKET} /mnt/s3
