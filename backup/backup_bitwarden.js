const fs = require('fs')
const { execSync } = require('child_process')

const filepath = '/Volumes/BACKUP/bitwarden/' + new Date().toLocaleDateString().replace(/\//g, '.') + '.gzip.gpg'
const jq = '/usr/local/bin/jq'
const bw = '/usr/local/bin/bw'
const gpg = '/usr/local/bin/gpg'
const gzip = '/usr/bin/gzip'

const sessionkey = execSync('security find-generic-password -w -s alfred-bitwarden-session-key').toString().trim()
const data = execSync(`${bw} list items --session ${sessionkey}`).toString().trim()
execSync(`export LC_ALL=en_US.UTF-8 && echo '${data}' | ${jq} | ${gzip} | ${gpg} --encrypt -r alex.popov.tech@gmail.com > ${filepath}`)
