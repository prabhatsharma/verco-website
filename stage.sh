#!/bin/sh

# clear the temp pubic directory
rm -rf public

# Generate static website. Files will be placed in public folder
hugo

# Move the files to S3 bucket for hosting
aws2 s3 sync ./public s3://test.vercosolutions.com/ --acl=public-read --profile=atal-admin

# invalidate cloudfront cache so that latest files can be served
aws2 cloudfront create-invalidation --distribution-id E12LYAYB27SHO7 --paths=/* --profile=atal-admin
