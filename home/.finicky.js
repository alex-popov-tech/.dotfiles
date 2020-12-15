module.exports = {
  defaultBrowser: {
        name: 'Google Chrome',
        profile: 'Profile 1'
  },
  handlers: [
    {
      match: [
        '*github*'
      ],
      browser: {
        name: 'Google Chrome',
        profile: 'Profile 1'
      }
    },
    {
      match: [
        'bcg-xchange.atlassian.net*',
        'id.svitla.com*',
        'bitbucket.org/xchangeteam*',
        'jenkins.container-xchange.com*',
      ],
      browser: {
        name: 'Google Chrome',
        profile: 'Profile 3'
      }
    },
    {
      match: ['beta.scrumpypoker.com*', 'mlitvinova.testrail.io*', 'digitalproducts.atlassian.net*'],
      browser: {
        name: 'Google Chrome',
        profile: 'Profile 4'
      }
    },
    {
      match: ['*lokalise*', '*meet.google*'],
      browser: {
        name: 'Google Chrome',
        profile: 'Profile 2'
      }
    },
    {
      match: /zoom.us\/j\//,
      browser: 'us.zoom.xos',
    },
  ],
};
