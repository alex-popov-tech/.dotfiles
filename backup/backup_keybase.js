const fs = require('fs')
const { execSync } = require('child_process')

const dest = '/Volumes/BACKUP/' + new Date().toLocaleDateString().replace(/\//g, '.') + '/'
const source = '/keybase/private/alex_popov_tech'

const stat = path => {
  const [relativePath, info] = execSync(`/usr/local/bin/keybase fs stat ${path}`).toString().trim().split('\n')
  const [modifiedDate, modifiedTime, _, type, size, name, userName, syncStatus] = info.replace(/\s+/g, ' ').split(' ')
  return { type }
}
const ls = path => execSync(`/usr/local/bin/keybase fs ls --one --nocolor ${path}`).toString().trim().split('\n').map(it => `${path}/${it}`)
const read = path => execSync(`/usr/local/bin/keybase fs read ${path}`)
const ensureDir = path => fs.mkdirSync(path, { recursive: true })
const ensureFile = (path, buffer) => fs.writeFileSync(path, buffer)

const syncKeybase = path => {
  const { type } = stat(path)
  if (type === 'DIR') {
    ensureDir(dest + path)
    const nodePaths = ls(path)
    for (const nodePath of nodePaths) syncKeybase(nodePath)
  } else if (type === 'FILE') {
    const content = read(path)
    ensureFile(dest + path, content)
  }
}

syncKeybase(source)
