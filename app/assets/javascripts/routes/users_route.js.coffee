App.UsersRoute = Ember.Route.extend
  renderTemplate: ->
    @render 'dashboard',
      into: 'application'
      outlet: 'dashboard'
      controller: 'currentUser'

    @render 'users/index',
      into: 'application'
      outlet: 'main'
      controller: 'users'