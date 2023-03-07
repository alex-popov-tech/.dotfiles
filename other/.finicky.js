const browsers = {
  options: {
    // Hide the finicky icon from the top bar. Default: false
    hideIcon: true,
    // Check for update on startup. Default: true
    checkForUpdate: true,
  },
  personal: {
    name: 'Arc',
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
