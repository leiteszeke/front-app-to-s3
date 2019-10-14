#!/bin/sh -l

set -e

if [ -z "$ACCESS_TOKEN" ] && [ -z "$GITHUB_TOKEN" ]
then
  echo "You must provide the action with either a Personal Access Token or the GitHub Token secret in order to deploy."
  exit 1
fi

echo "Installing tools.." && \
apt-get update && \
apt-get install -y git && \
apt-get install supervisor python3-pip supervisor vim -y && \
apt-get update -y && \
pip3 install --upgrade --user awscli && \

echo "Export path" && \
export PATH=~/.local/bin:$PATH && \

# Directs the action to the the Github workspace.
echo "Moving to ${GITHUB_WORKSPACE}.." && \
cd $GITHUB_WORKSPACE && \

# Clone repository
git clone https://${ACCESS_TOKEN:-"x-access-token:$GITHUB_TOKEN"}@github.com/${GITHUB_REPOSITORY}.git . && \

# Checks out to master.
git checkout master && \

if [ -z "$BUILD_SCRIPTS" ]
then
  # Install dependencies
  echo "Installing dependencies.." && \
  eval "yarn install" && \

  # Builds the project
  echo "Running build scripts.." && \
  eval "yarn build"
else
  # Running commands
  echo "Running build scripts.." && \
  eval ${BUILD_SCRIPTS}
fi

echo "Where is aws?" && \
eval which aws && \

### echo "Reload bash profile" && \
### . ~/.bash_profile && \

echo "Get PATH variable" && \
echo $PATH && \

echo "Get AWS Cli version" && \
aws --version && \

# Deploy to S3
echo "Run set region..." && \
aws configure set region ${AWS_REGION} && \
echo "Run set access key..." && \
aws configure set aws_access_key_id ${AWS_ACCESS_KEY_ID} && \
echo "Run set secret key..." && \
aws configure set aws_secret_access_key ${AWS_SECRET_ACCESS_KEY} && \
echo "Run sync..." && \
aws s3 sync ${FOLDER} s3://${BUCKET} --acl public-read
