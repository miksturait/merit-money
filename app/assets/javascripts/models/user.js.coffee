App.User = DS.Model.extend
  kudoReceiveds: DS.hasMany('App.KudoReceived')
  kudoLastWeeks: DS.hasMany('App.KudoLastWeek')
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

  kudosReceivedNum: Ember.computed(->
    kudosTotal = 0
    if @get 'kudoReceiveds'
      @get('kudoReceiveds').forEach (item) ->
        kudosTotal += item.get 'value'

      kudosTotal
  ).property('kudoReceiveds.@each')

App.User.FIXTURES = [
  id: 1
  name: 'Michał Czyż'
  email: 'michalczyz@gmail.com'
  kudoReceived: [1]
  kudoLastWeek: [1, 2, 3]
,
  id: 2
  name: 'Boro'
  email: 'boro.selleo@gmail.com'
  kudoReceived: [2, 3]
  kudoLastWeek: [4, 5, 6, 7]
,
  id: 3
  name: 'Wojtek'
  email: 'rrh@op.pl'
  kudoReceived: []
  kudoLastWeek: []
]