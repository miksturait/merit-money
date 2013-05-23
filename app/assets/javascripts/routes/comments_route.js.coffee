Sks.CommentsRoute = Ember.Route.extend
  model: ->
    Sks.Comment.find()

  setupController: (controller, model) ->
    @controllerFor('currentUser').set 'content', Sks.CurrentUser.find(1)

  renderTemplate: ->
    @render 'dashboard',
      into: 'application'
      outlet: 'dashboard'
      controller: 'currentUser'

    @render 'comments',
      into: 'application'
      outlet: 'main'
      controller: 'comments'