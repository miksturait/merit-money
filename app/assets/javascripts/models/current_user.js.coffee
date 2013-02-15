Sks.CurrentUser = Sks.User.extend(
  kudosLeft: DS.attr("integer")
  kudosReceived: DS.attr("integer")
  kudosReceivedSinceLastBonus: DS.attr("integer")
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