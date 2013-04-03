Sks.CurrentUser = Sks.User.extend(
  kudosLeft: DS.attr("number")
  kudosReceived: DS.attr("number")
  kudosTotalReceived: DS.attr("number")
)

Sks.CurrentUser.FIXTURES = [
  "id": 1
  "firstName": "Aldona"
  "lastName": "Adamiak"
  "email": "rrh@op.pl"
  "kudosLeft": 19
  "kudosReceived": 18
  "kudosReceivedSinceLastBonus": 50
]