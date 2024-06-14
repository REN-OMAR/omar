#!/bin/bash

# echo $PWD
###opts
# set -e          #exit on error
set -o pipefail #fail on error in pipechain
set -x          #debug
time(
	npx tsc
	cp -r dist/* ./
	deta deploy
	rm -rf dist core index.js* &
)
