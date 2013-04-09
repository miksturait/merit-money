Sks.ApplicationRoute = Ember.Route.extend
  events:
    addKudo: (user) ->
      showFlash = (type, message) ->
        $("#flash")
          .addClass(type)
          .empty()
          .append(message)
          .show()
          .fadeIn()
          .delay(2000)
          .fadeOut 'slow'

      self = this
      token = $('meta[name="csrf-token"]').attr('content')
      cuController = Sks.Router.get 'currentUserController'
      console.log cuController.kudosLeft

      jQuery.post("/kudos", user_id: user.get("id"), authenticity_token: token)
      .done((data, status) =>
        kudosLeft = self.get 'controllers.currentUser.kudosLeft'
        if kudosLeft > 0
          self.decrementProperty "controllers.currentUser.kudosLeft"
          showFlash 'alert-success', 'You\'ve added a kudo!'
        else
          showFlash 'alert-error', 'There\'re no kudos left!'
      )
      .fail (data, status) ->
        showFlash 'alert-error', 'Oops! An error occured!'
