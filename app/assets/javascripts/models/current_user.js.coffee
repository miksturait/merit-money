App.CurrentUser = App.User.extend
  kudosLeft: DS.attr 'number'
  kudosReceived: DS.attr 'number'
  kudosTotalReceived: DS.attr 'number'
  trend: DS.attr 'string'

App.CurrentUser.FIXTURES = [
  id: 1
  kudosLeft: 20
  kudosReceived: 10
  kudosTotalReceived: 23
  trend: 'upward' # steady, upward, downward
]