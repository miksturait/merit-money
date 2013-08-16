App.User = DS.Model.extend
  kudoReceiveds: DS.hasMany('App.KudoReceived')
  kudoLastWeeks: DS.hasMany('App.KudoLastWeek')
  name: DS.attr("string")
  email: DS.attr("string")

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