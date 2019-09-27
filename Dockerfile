FROM node:10

LABEL "com.github.actions.name"="Build React App"
LABEL "com.github.actions.description"="This action will build your React App."
LABEL "com.github.actions.icon"="git-commit"
LABEL "com.github.actions.color"="orange"

LABEL "repository"="http://github.com/leiteszeke/github-react-build"
LABEL "homepage"="http://github.com/leiteszeke/github-react-build"
LABEL "maintainer"="Ezequiel Leites <ezequiel@leites.dev>"

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
