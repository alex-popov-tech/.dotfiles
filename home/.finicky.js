const name = 'Brave Browser';
const profiles = {
  personal: 'Profile 4',
  lokalise: 'Profile 5',
  waverley: 'Profile 6',
  svitla: 'Profile 7',
};
module.exports = {
  defaultBrowser: {
        name,
        profile: profiles.personal
  },
  handlers: [
    {
      match: [ '*github*' ],
      browser: {
        name,
        profile: profiles.personal,
      }
    },
    {
      match: ['*lokalise*', '*meet.google*'],
      browser: {
        name: 'Brave Browser',
        profile: profiles.lokalise,
      }
    },
    {
      match: ['mlitvinova.testrail.io*', 'digitalproducts.atlassian.net*'],
      browser: {
        name,
        profile: profiles.waverley,
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
        name,
        profile: profiles.svitla
      }
    },
    {
      match: /zoom.us\/j\//,
      browser: 'us.zoom.xos',
    },
  ],
};
