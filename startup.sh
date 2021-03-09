#!/bin/sh

if [[ "$PORT" == "29175" ]]; then
    export OTHER_PORT="31786"
else
    export OTHER_PORT="29175"
fi

URL_PARTS=$(mktemp)
parse-url $(echo "\$$DATABASE_VAR" | envsubst) > "$URL_PARTS"
source $URL_PARTS

envsubst '$PORT $OTHER_PORT' \
        < /etc/nginx/nginx.conf.template \
        > /etc/nginx/nginx.conf

envsubst \
        < config.yml.template \
        > config.yml

echo
echo "===== Db Variables ====="
cat $URL_PARTS

echo
echo "===== Wiki.js Conf ====="
cat config.yml

echo

unset DATABASE_URL

nginx
node server
