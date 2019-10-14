FROM node:10

LABEL "com.github.actions.name"="Front App to Amazon s3"
LABEL "com.github.actions.description"="This action will build your front end app and deploy it to Amazon S3 Bucket."
LABEL "com.github.actions.icon"="git-commit"
LABEL "com.github.actions.color"="orange"

LABEL "repository"="http://github.com/leiteszeke/front-app-to-s3"
LABEL "homepage"="http://github.com/leiteszeke/front-app-to-s3"
LABEL "maintainer"="Ezequiel Leites <ezequiel@leites.dev>"

ADD ./entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]