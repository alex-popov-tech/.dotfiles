module.exports = {
  defaultBrowser: "Google Chrome",
  handlers: [
    {
      match: ['bcg-xchange.atlassian.net*', 'id.svitla.com*'],
      browser: 'Safari'
    },
    {
      match: ['beta.scrumpypoker.com*', 'mlitvinova.testrail.io*'],
      browser: 'Opera'
    },
    {
      match: /zoom.us\/j\//,
      browser: "us.zoom.xos"
    }
  ]
};
