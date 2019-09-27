FROM node:10

LABEL "com.github.actions.name"="Build React App and Deploy to S3 Bucket"
LABEL "com.github.actions.description"="This action will build your React App and deploy it to a Amazon S3 Bucket."
LABEL "com.github.actions.icon"="git-commit"
LABEL "com.github.actions.color"="orange"

LABEL "repository"="http://github.com/leiteszeke/github-react-to-s3"
LABEL "homepage"="http://github.com/leiteszeke/github-react-to-s3"
LABEL "maintainer"="Ezequiel Leites <ezequiel@leites.dev>"

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
