FROM node:10

ENV ACCESS_TOKEN mitokenvlaue

LABEL "com.github.actions.name"="Build React App"
LABEL "com.github.actions.description"="This action will build your React App."
LABEL "com.github.actions.icon"="git-commit"
LABEL "com.github.actions.color"="orange"

LABEL "repository"="http://github.com/leiteszeke/github-react-build"
LABEL "homepage"="http://github.com/leiteszeke/github-react-build"
LABEL "maintainer"="Ezequiel Leites <ezequiel@leites.dev>"

ADD ./supervisord.conf /etc/supervisord.conf
ADD ./entrypoint.sh ./entrypoint.sh

RUN set -x \
	&& apt update \
	&& apt install supervisor git-core python3-pip supervisor vim -y \
    && apt update -y \
    && pip3 install --upgrade --user awscli

ENTRYPOINT ["/entrypoint.sh"]