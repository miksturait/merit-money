Sks.User = DS.Model.extend
  kudosReceived: DS.hasMany 'Sks.kudoReceived'
  kudosLastWeek: DS.hasMany 'Sks.kudoLastWeek'
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
    num: 2
    comment_ids: [1]
    comments: [
      id: 1
      body: 'Because you are nice to me!'
    ]
  ]
  kudoLastWeek_ids: [1]
  kudosLastWeek: [
    id: 1
    num: 5
    comment_ids: [1, 2]
    comments: [
      id: 1
      body: 'You gave me a helping hand yesterday!'
    ,
      id: 2
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
    num: 3
    comment_ids: [1, 2]
    comments: [
      id: 1
      body: 'It was a huge help, man!'
    ,
      id: 2
      body: 'It was awesome!'
    ]
  ]
  kudoLastWeek_ids: [1]
  kudosLastWeek: [
    id: 1
    num: 7
    comment_ids: [1, 2, 3, 4]
    comments: [
      id: 1
      body: 'Thanks for the dinner!'
    ,
      id: 2
      body: 'you did amazing job'
    ,
      id: 3
      body: 'Keep it up man!'
    ,
      id: 4
      body: 'unbelievable!!!'
    ]
  ]
]