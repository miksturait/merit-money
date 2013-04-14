Sks.User = DS.Model.extend
  kudosReceived: DS.hasMany('Sks.KudoReceived') 
  kudosLastWeek: DS.hasMany('Sks.KudoLastWeek')
  name: DS.attr("string")
  email: DS.attr("string")

  gravatar: Ember.computed(->
    email = @get("email") || ""
    "http://www.gravatar.com/avatar/" + MD5(email)
  ).property("email")

  firstName: Ember.computed(->
    fName = @get('name').split(' ')[0]
  ).property("name")

  lastName: Ember.computed(->
    lName = @get('name').split(' ')[1]
  ).property("name")

Sks.User.FIXTURES = [
  id: 1
  name: 'Michał Czyż'
  email: 'michalczyz@gmail.com'
  kudosReceived: [1]
  kudosLastWeek: [1, 2, 3]
,
  id: 2
  name: 'Boro'
  email: 'boro.selleo@gmail.com'
  kudosReceived: [2, 3]
  kudosLastWeek: [4, 5, 6, 7]
,
  id: 3
  name: 'Wojtek'
  email: 'rrh@op.pl'
  kudosReceived: []
  kudosLastWeek: []
]