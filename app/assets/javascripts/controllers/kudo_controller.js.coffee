Sks.KudoController = Ember.ObjectController.extend
  needs: ['currentUser']
  addKudo: (user) ->
    self = this
    token = $('meta[name="csrf-token"]').attr('content')
    ErrorMessageTmplt = """
      <div id="kudos-flash" class="alert" alert-error" style="display: none">
        <a class="close" data-dismiss="alert" href="#">&times;</a>
        <strong>oops! an error occured!</strong>
      </div>
    """
    $flashContainer = jQuery '#flash-container'

    jQuery.post("/kudos", user_id: user.get("id"), authenticity_token: token)
    .done((data, status) ->
      kudosLeft = self.get 'controllers.currentUser.kudosLeft'
      console.log self.get "controllers.currentUser.kudosLeft"
      if kudosLeft > 0
        self.decrementProperty "controllers.currentUser.kudosLeft" 
      else 
        $flashContainer.empty()
        jQuery(ErrorMessageTmplt).appendTo($flashContainer).show()
    )
    .fail((data, status) ->
        $flashContainer.empty()
        jQuery(ErrorMessageTmplt).appendTo($flashContainer).show()
    )
