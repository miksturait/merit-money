Sks.User = DS.Model.extend
  kudosReceived: DS.hasMany 'Sks.KudoReceived'
  kudosLastWeek: DS.hasMany 'Sks.KudoLastWeek'
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
  kudoReceived_ids: [1]
  kudosReceived: [
    id: 1
    value: 2
    comment: 'Because you are nice to me!'
  ]
  kudoLastWeek_ids: [1, 2, 3]
  kudosLastWeek: [
    id: 1
    value: 3
    comment: 'You gave me a helping hand yesterday!'
  ,
    id: 2
    value: 2
    comment: 'It was awesome!'
  ,
    id: 3
    value: 1
    comment: 'for no reason!'
  ]
,
  id: 2
  name: 'Boro'
  email: 'boro.selleo@gmail.com'
  kudoReceived_ids: [1, 2]
  kudosReceived: [
    id: 1
    value: 2
    comment: 'you did amazing job'
  ,
    id: 2
    value: 4
    comment: 'Keep it up, dude!'
  ]
  kudoLastWeek_ids: [1, 2, 3, 4]
  kudosLastWeek: [
    id: 1
    value: 5
    comment: 'Unbelievable!'
  ,
    id: 2
    value: 1
    comment: 'cool'
  ,
    id: 3
    value: 1
    comment: 'uh-oh'
  ,
    id: 4
    value: 3
    comment: 'super-duper!'
  ]
]