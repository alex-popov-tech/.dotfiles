const browsers = {
  options: {
    // Hide the finicky icon from the top bar. Default: false
    hideIcon: true,
    // Check for update on startup. Default: true
    checkForUpdate: true,
  },
  personal: {
    name: "Arc",
  },
  lokalise: {
    name: "Brave Browser",
    profile: "Profile 1",
  },
  kandc: {
    name: "Brave Browser",
    profile: "Default",
  },
  of: {
    name: "Brave Browser",
    profile: "Profile 3",
  },
};

module.exports = {
  defaultBrowser: browsers.personal,
  handlers: [
    {
      match: /zoom.us\/j\//,
      browser: "us.zoom.xos",
    },
    {
      match: ["*informa*", "*krusche*", "*knect*", "*informaconnect*", "*knnlab*", "*itmebusiness*", ".*itmebusiness.*"],
      browser: browsers.kandc,
    },
    {
      match: ["*retloko*", "*onlyfans*"],
      browser: browsers.of,
    },
  ],
};
