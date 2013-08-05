App.UsersRoute = Ember.Route.extend
  setupController: ->
    @controllerFor('users').set 'content', App.User.all()
    @controllerFor('currentUser').set 'content', App.CurrentUser.find(1)
    @controllerFor('top').set 'content', App.Top.all()
    @controllerFor('hamsters').set 'content', App.Hamster.all()

  renderTemplate: ->
    @render 'dashboard',
      into: 'application'
      outlet: 'dashboard'
      controller: 'currentUser'

    @render 'users',
      into: 'application'
      outlet: 'main'
      controller: 'users'