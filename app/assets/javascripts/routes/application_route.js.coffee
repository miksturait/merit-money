Sks.ApplicationRoute = Ember.Route.extend Ember.Evented,
  events:
    addKudo: (user) ->
      self = @
      token = $('meta[name="csrf-token"]').attr 'content'
      currentUserCon = @controllerFor 'currentUser'

      # prevent from multi-clicking
      return if currentUserCon.get 'disableAddingKudos'

      currentUserCon.set 'disableAddingKudos', true

      setTimeout ->
        currentUserCon.set 'disableAddingKudos', false
      , 1500

      kudosLeft = currentUserCon.get 'kudosLeft'
      $visibleContent = $('#users-list').find '.form-visible'
      kudoNum = $visibleContent.find('.stars').raty('score') || 1
      $kudoComment = $visibleContent.find('.kudos-comment')
      kudoComment = $kudoComment.val()



      kudo = Sks.Kudo.createRecord receiver: user, value: kudoNum, comment: kudoComment
      $.post("/kudos", kudo: kudo.serialize(), authenticity_token: token)
      .done((data) =>
        if data.status isnt 'error'
          currentUserCon.decrementKudos kudoNum
          newKudo = Sks.KudoReceived.createRecord value: kudoNum, comment: kudoComment
          user.get('kudoReceiveds').pushObject(newKudo)
          self.trigger 'kudoAdded', 'success', value: kudoNum, comment: kudoComment
        else
          self.trigger 'kudoAdded', 'error'
      )
      .fail (data, status) ->
        self.trigger 'kudoAdded', 'error'

