#!/bin/sh

# clear the temp pubic directory
rm -rf public

# Generate static website. Files will be placed in public folder
hugo

# Move the files to S3 bucket for hosting
aws s3 sync ./public s3://vercosolutions.com/ --acl=public-read --profile=atal-admin

# invalidate cloudfront cache so that latest files can be served
aws cloudfront create-invalidation --distribution-id E2WOVHCXX4K7ZQ --paths=/* --profile=atal-admin
