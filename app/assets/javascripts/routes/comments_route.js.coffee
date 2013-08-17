App.CommentsRoute = Ember.Route.extend
  renderTemplate: ->
    @render 'dashboard',
      into: 'application'
      outlet: 'dashboard'
      controller: 'currentUser'

    @render 'comments',
      into: 'application'
      outlet: 'main'
      controller: 'comments'