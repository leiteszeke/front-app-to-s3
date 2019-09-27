#!/bin/sh -l

set -e

if [ -z "$ACCESS_TOKEN" ] && [ -z "$GITHUB_TOKEN" ]
then
  echo "You must provide the action with either a Personal Access Token or the GitHub Token secret in order to deploy."
  exit 1
fi

FOLDER=build

# Installs Git and jq.
apt-get update && \
apt-get install -y git && \
apt-get install -y awscli && \

# Directs the action to the the Github workspace.
cd $GITHUB_WORKSPACE && \

# Configures Git.
git init && \

## Initializes the repository path using the access token.
REPOSITORY_PATH="https://${ACCESS_TOKEN:-"x-access-token:$GITHUB_TOKEN"}@github.com/${GITHUB_REPOSITORY}.git" && \

# Checks out the base branch to begin the deploy process.
git checkout master && \

# Builds the project if a build script is provided.
echo "Running build scripts... $BUILD_SCRIPT" && \
eval "$BUILD_SCRIPT" && \

if [ "$CNAME" ]; then
  echo "Generating a CNAME file in in the $FOLDER directory..."
  echo $CNAME > $FOLDER/CNAME
fi