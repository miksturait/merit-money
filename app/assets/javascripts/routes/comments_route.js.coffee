Sks.CommentsRoute = Ember.Route.extend
  model: ->
    Sks.Comment.find()

  setupController: (controller, model) ->
    @controllerFor('currentUser').set 'content', Sks.CurrentUser.find 1