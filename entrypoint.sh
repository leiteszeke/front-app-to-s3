#!/bin/sh -l

set -e

if [ -z "$ACCESS_TOKEN" ] && [ -z "$GITHUB_TOKEN" ]
then
  echo "You must provide the action with either a Personal Access Token or the GitHub Token secret in order to deploy."
  exit 1
fi

FOLDER=build

# Installs Git
apt-get update && \
apt-get install -y git && \
apt-get install supervisor python3-pip supervisor vim -y && \
apt-get update -y && \
pip3 install --upgrade --user awscli && \
eval "export PATH=/root/.local/bin:$PATH" && \

# Directs the action to the the Github workspace.
cd $GITHUB_WORKSPACE && \

# Clone repository
git clone https://${ACCESS_TOKEN:-"x-access-token:$GITHUB_TOKEN"}@github.com/${GITHUB_REPOSITORY}.git . && \

# Checks out to master.
git checkout master && \

# Install dependencies
echo "Installing dependencies.." && \
eval "yarn install" && \

# Builds the project
echo "Running build scripts.." && \
eval "yarn build" && \

# Deploy to S3
/root/.local/bin/aws configure set region ${AWS_REGION} && \
/root/.local/bin/aws configure set aws_access_key_id ${AWS_ACCESS_KEY_ID} && \
/root/.local/bin/aws configure set aws_secret_access_key ${AWS_SECRET_ACCESS_KEY} && \
/root/.local/bin/aws s3 sync ${FOLDER} s3://${BUCKET} --acl public-read