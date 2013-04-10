Sks.ApplicationRoute = Ember.Route.extend
  events:
    addKudo: (user) ->
      self = @
      token = $('meta[name="csrf-token"]').attr 'content'
      currentUserCon = @controllerFor 'currentUser'
      kudosLeft = currentUserCon.get 'kudosLeft'

      showFlash = (type, message) ->
        $("#flash")
          .addClass(type)
          .empty()
          .append(message)
          .show()
          .fadeIn()
          .delay(2000)
          .fadeOut 'slow'

      $.post("/kudos", user_id: user.get("id"), authenticity_token: token)
      .done((data, status) =>
        if kudosLeft > 0
          currentUserCon.decrementKudos 1
          showFlash 'alert-success', 'You\'ve added a kudo!'
        else
          showFlash 'alert-error', 'There\'re no kudos left!'
      )
      .fail (data, status) ->
        showFlash 'alert-error', 'Oops! An error occured!'
