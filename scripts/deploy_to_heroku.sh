#!/bin/bash

# echo $PWD
###opts
# set -e          #exit on error
set -o pipefail #fail on error in pipechain
#set -x          #debug

echo "Script executed from: ${PWD}"

cd $(dirname $0) && cd ..
echo "now at: ${PWD}"

echo $1
if [[ "$#" != 1 ]]; then
        echo "use $0 APP_NAME"
		exit 1
fi

./scripts/get_git_data.sh

HEROKU_APP_NAME=$1
heroku config:set APP_NAME=${HEROKU_APP_NAME} HOST_NAME=${HEROKU_APP_NAME}.herokuapp.com --app ${HEROKU_APP_NAME}

# git fetch --all
git pull
git push heroku dirtyInit:master