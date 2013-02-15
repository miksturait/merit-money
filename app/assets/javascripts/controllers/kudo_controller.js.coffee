Sks.KudoController = Ember.ObjectController.extend
  needs: ['currentUser']
  addKudo: (user) ->
    kudosLeft = @get 'controllers.currentUser.kudosLeft'

#    jQuery.post "/kudo/" + user.get("id"), jQuery.proxy(->
#      @decrementProperty "controllers.current.kudosLeft"
#    , this)

    # here we send POST to /kudo/userid and when it finishes
    # we decrement kudosLeft in currentUser
    @decrementProperty "controllers.currentUser.kudosLeft"  if kudosLeft > 0
