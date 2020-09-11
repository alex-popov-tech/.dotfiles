module.exports = {
  defaultBrowser: 'Google Chrome',
  handlers: [
    {
      match: [
        'bcg-xchange.atlassian.net*',
        'id.svitla.com*',
        'bitbucket.org/xchangeteam*',
        'jenkins.container-xchange.com*',
      ],
      browser: 'Safari',
    },
    {
      match: ['beta.scrumpypoker.com*', 'mlitvinova.testrail.io*', 'digitalproducts.atlassian.net*'],
      browser: 'Opera',
    },
    {
      match: ['*cake.hr*', '*lokalise.atlassian.net*', '*lokalise.cake.hr'],
      browser: 'Firefox',
    },
    {
      match: /zoom.us\/j\//,
      browser: 'us.zoom.xos',
    },
  ],
};
