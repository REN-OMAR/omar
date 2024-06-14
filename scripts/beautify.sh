#!/bin/bash

echo "Script executed from: ${PWD}"

cd $(dirname $0) && cd ..

js-beautify -b collapse,preserve-inline -n -t -r $(find . -type f \( -name "*.json" -o -name "*.css" -o -name "*.html" -o -name "*.js" \) -not -path "./node_modules/*")

if [[ $? == 1 ]]; then
        PASS=false
fi
if ! $PASS; then
        printf "COMMIT FAILED\n"
        exit 1
else
        printf "COMMIT SUCCEEDED\n"
fi

exit 0
