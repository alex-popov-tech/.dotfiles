function ReInstall() {
  var triggers = ScriptApp.getProjectTriggers();
  for (var i=0; i<triggers.length; i++) {
    ScriptApp.deleteTrigger(triggers[i]);
  }
  ScriptApp.newTrigger("start")
      .timeBased()
      .at(new Date())
      .create();
  ScriptApp.newTrigger("start")
      .timeBased()
      .everyHours(1)
      .create();
}

function start() {
  var SEARCHES_TO_DELETE = ['subject:BACKUP_ERROR older_than:1h'];
  for (var search of SEARCHES_TO_DELETE) {
    var threads = GmailApp.search(search);
    for (var thread of threads) {
       Gmail.Users.Messages.remove('me', thread.getId());
    }
  }
}
