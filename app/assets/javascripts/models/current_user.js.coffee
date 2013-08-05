App.CurrentUser = App.User.extend
  kudosLeft: DS.attr 'number'
  kudosReceived: DS.attr 'number'
  kudosTotalReceived: DS.attr 'number'
  trend: DS.attr 'string'