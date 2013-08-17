App.CommentsRoute = Ember.Route.extend
  renderTemplate: ->
    @render 'shared/dashboard',
      into: 'application'
      outlet: 'dashboard'
      controller: 'currentUser'

    @render 'comments/index',
      into: 'application'
      outlet: 'main'
      controller: 'comments'