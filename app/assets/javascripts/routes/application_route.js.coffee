Sks.ApplicationRoute = Ember.Route.extend
  events:
    addKudo: (user) ->
      self = @
      token = $('meta[name="csrf-token"]').attr 'content'
      currentUserCon = @controllerFor 'currentUser'
      kudosLeft = currentUserCon.get 'kudosLeft'
      $kudoSelect = $ '#kudos-add'
      $kudoComment = $ '#kudos-comment'
      kudoNum = parseInt $kudoSelect.val() || 1
      kudoComment = $kudoComment.val()

      showFlash = (type, message) ->
        $("#flash")
          .removeClass('alert-error alert-success')
          .addClass(type)
          .empty()
          .append(message)
          .show()
          .fadeIn()
          .delay(2000)
          .fadeOut 'slow'

      kudo = Sks.Kudo.createRecord receiver: user, value: kudoNum, comment: kudoComment
      $.post("/kudos", kudo: kudo.serialize(), authenticity_token: token)
      .done((data) =>
        if data.status isnt 'error'
          currentUserCon.decrementKudos kudoNum
          newKudo = Sks.KudoReceived.createRecord value: kudoNum, comment: kudoComment
          #user.get('kudoReceived').pushObject(newKudo)
          showFlash 'alert-success', 'You\'ve added a kudo!'
        else
          showFlash 'alert-error', 'Oops! An error occured!'
      )
      .fail (data, status) ->
        showFlash 'alert-error', 'Oops! An error occured!'
      .always ->
          $kudoComment.val ''
