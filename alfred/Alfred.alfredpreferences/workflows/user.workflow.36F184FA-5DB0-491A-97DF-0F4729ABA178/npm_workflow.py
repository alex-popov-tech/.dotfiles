#!/usr/bin/python
# encoding: utf-8
import os
import hashlib
import functools
import sys
from workflow import Workflow, web, ICON_WEB


PACKAGE_NUM = 3
MAX_AGE = 30
IMAGE_SIZE = 25
MAX_IMAGE_NUM = 15

if sys.version_info[0] >= 3:
    from urllib.request import urlretrieve
else:
    # Not Python 3 - today, it is most likely to be Python 2
    # But note that this might need an update when Python 4
    # might be around one day
    from urllib import urlretrieve

reload(sys)
sys.setdefaultencoding('utf-8')

# download avator image
def download(hash):
  filename = '{}{}{}{}'.format('avator', os.sep, hash, '.jpeg')
  # log.debug('file isexist: {}'.format(os.path.isfile(filename)))
  if not os.path.isfile(filename):
    urlretrieve("https://s.gravatar.com/avatar/{}?size={}&default=retro".format(hash, IMAGE_SIZE), filename=filename)
  else:
    pass

# clear avator image when the number of files was greater than 10
def clearAvator():
  for root, dirs, files in os.walk('./avator'):
    if len(files) >= MAX_IMAGE_NUM:
      for name in files:
        try:
          os.remove(os.path.join(root, name))
        except:
          pass
    else:
      pass

# fetch npm packages list
def queryPackage(query):
  url = "https://registry.npmjs.com/-/v1/search?text={}&from=0&size={}&quality=1.95&popularity=3.3&maintenance=2.05".format(query, PACKAGE_NUM)
  return web.get(url).json()


def main(wf):
  # Update available?
  if wf.update_available:
      wf.add_item('A newer version is available',
                  '↩ to install update',
                  autocomplete='workflow:update',
                  icon='icon.png')

  query = wf.args[0].strip().replace('/', '%2F')

  data = wf.cached_data(query, functools.partial(queryPackage, query), max_age=MAX_AGE)
  # log.debug('query value is {}'.format(query))
  # log.debug('data is {}'.format(data))

  if len(data[u'objects']) > 0:
    clearAvator()
    for obj in data[u'objects']:
      package = obj[u'package']
      log.debug('package: {}'.format(package))
      title = package[u'name']
      version = package[u'version']
      try:
        subtitle = package[u'description']
      except:
        subtitle = 'no description'
      link = package[u'links'][u'npm']

      avatar = hashlib.md5()
      avatar.update(package[u'publisher'][u'email'])
      avatarHash = avatar.hexdigest()
      download(avatarHash)

      wf.add_item(title="{} {}".format(title, version),
                  subtitle=subtitle,
                  arg=link,
                  valid=True,
                  icon='avator/{}.jpeg'.format(avatarHash))
  else:
    wf.add_item(title="No {} package".format(query), subtitle='',arg='',valid=True,icon='icon.png')
  wf.send_feedback()




if __name__ == u"__main__":
  wf = Workflow()
  log = wf.logger
  sys.exit(wf.run(main))
