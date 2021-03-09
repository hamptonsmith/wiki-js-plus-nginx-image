FROM nginx:1.19-alpine

RUN apk add --no-cache nodejs

COPY nginx.conf.template /etc/nginx/nginx.conf.template

RUN wget https://github.com/Requarks/wiki/releases/download/2.5.170/wiki-js.tar.gz
RUN mkdir wiki
RUN tar xzf wiki-js.tar.gz -C ./wiki
COPY wikijs.yml.template /wiki/config.yml.template

WORKDIR /wiki/

COPY startup.sh /usr/bin/startupwiki.sh
RUN chmod a+x /usr/bin/startupwiki.sh

COPY parse-url.js /usr/bin/parse-url
RUN chmod a+x /usr/bin/parse-url

CMD /usr/bin/startupwiki.sh
