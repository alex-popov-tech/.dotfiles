const browsers = {
  personal: {
    name: 'Brave Browser',
  },
  lokalise: {
    name: 'Brave Browser',
    profile: 'Profile 1'
  },
};

module.exports = {
  defaultBrowser: browsers.personal,
  handlers: [
    {
      match: /zoom.us\/j\//,
      browser: 'us.zoom.xos',
    },
    {
      match: [
        '*lokalise*',
        'https://meet.google.com/isy-mnwr-mas*',
        'https://meet.google.com/pfu-saon-rqy',
        '*greenhouse*',
        '*papayaglobal*',
      ],
      browser: browsers.lokalise
    },
  ],
};
