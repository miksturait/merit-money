Sks.ApplicationRoute = Ember.Route.extend
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
          user.get('kudoReceiveds').pushObject(newKudo)
          showFlash 'alert-success', "You've added #{kudoNum} kudo(s)!"
        else
          showFlash 'alert-error', 'Oops! An error occured!'
      )
      .fail (data, status) ->
        showFlash 'alert-error', 'Oops! An error occured!'
      .always ->
          $kudoComment.val ''


