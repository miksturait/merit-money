Sks.User = DS.Model.extend(
  firstName: DS.attr("string")
  lastName: DS.attr("string")
  email: DS.attr("string")

  fullName: Ember.computed(->
    firstName = @get("firstName") || ""
    lastName = @get("lastName") || ""
    "#{firstName} #{lastName}"
  ).property("firstName", "lastName")

  gravatar: Ember.computed(->
    email = @get("email") || ""
    "http://www.gravatar.com/avatar/" + MD5(email)
  ).property("email")
)

Sks.User.FIXTURES = [
  id: 1
  firstName: "Adam"
  lastName: "Adamiak"
  email: "rrh@op.pl"
,
  id: 2
  firstName: "Alicja"
  lastName: "Adamiak"
  email: "rrh@op.pl"
,
  id: 3
  firstName: "Adam"
  lastName: "Kowalski"
  email: "rrh@op.pl"
,
  id: 4
  firstName: "Alicja"
  lastName: "Kowalski"
  email: "rrh@op.pl"
,
  id: 5
  firstName: "Aldona"
  lastName: "Kowalski"
  email: "rrh@op.pl"
]