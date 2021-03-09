#!/usr/bin/env node

const { URL } = require('url');

const url = new URL(process.argv[2]);

console.log(`
    export DB_HOST=${url.hostname}
    export DB_PORT=${url.port}
    export DB_USER=${url.username}
    export DB_PASS=${url.password}
    export DB_NAME=${url.pathname.substring(1)}
`);
