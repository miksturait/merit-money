Sks.UsersRoute = Ember.Route.extend
  setupController: ->
    @controllerFor('users').set 'content', Sks.User.all()
    @controllerFor('currentUser').set 'content', Sks.CurrentUser.find(1)
    @controllerFor('top').set 'content', Sks.Top.all()
    @controllerFor('hamsters').set 'content', Sks.Hamster.all()

  renderTemplate: ->
    @render 'dashboard',
      into: 'application'
      outlet: 'dashboard'
      controller: 'currentUser'

    @render 'users',
      into: 'application'
      outlet: 'main'
      controller: 'users'