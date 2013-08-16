App.ApplicationController = Ember.Controller.extend
  status: null
  kudoAddedNum: null

  addKudo: (userId, value, comment) ->
    self = @
    token = $('meta[name="csrf-token"]').attr 'content'
    currentUserCon = @controllerFor 'currentUser'

    # TODO - refactor this!
    # prevent from multi-clicking
    return if currentUserCon.get 'disableAddingKudos'

    currentUserCon.set 'disableAddingKudos', true

    setTimeout ->
      currentUserCon.set 'disableAddingKudos', false
    , 1500

    kudosLeft = currentUserCon.get 'kudosLeft'

    # TODO don't use jQuery Ajax - use Ember Data transitions instead
    receiver = App.User.find userId
    kudo = App.Kudo.createRecord receiver: receiver, value: value, comment: comment
    $.post("/kudos", kudo: kudo.serialize(), authenticity_token: token)
    .done((data) =>
      if data.status isnt 'error'
        currentUserCon.decrementKudos value
        newKudo = App.KudoReceived.createRecord value: value, comment: comment
        receiver.get('kudoReceiveds').pushObject(newKudo)
        self.set('status', 'success')
        self.set('kudoAddedNum', value)
      else
        self.set('status', 'error')
    )
    .fail (data, status) ->
      self.set('status', 'error')




