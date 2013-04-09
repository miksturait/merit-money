Sks.User = DS.Model.extend
  kudosReceived: DS.hasMany 'Sks.kudoReceived'
  #kudosLastWeek: DS.hasMany 'Sks.kudosLastWeek'
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
    num: 5
    comment_ids: [1, 2, 3]
    comments: [
      id: 1
      body: 'Because you are nice to me!'
    ,
      id: 2
      body: 'You gave me a helping hand yesterday!'
    ,
      id: 3
      body: 'Whatever!'
    ]
  ]
,
  id: 2
  name: 'Boro'
  email: 'boro.selleo@gmail.com'
  kudoReceived_ids: [1]
  kudosReceived: [
    id: 1
    num: 5
    comment_ids: [1, 2, 3]
    comments: [
      id: 1
      body: 'Because you are nice to me!'
    ,
      id: 2
      body: 'You gave me a helping hand yesterday!'
    ,
      id: 3
      body: 'Whatever!'
    ]
  ]
]