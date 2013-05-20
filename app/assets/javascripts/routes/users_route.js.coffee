Sks.UsersRoute = Ember.Route.extend
  setupController: (controller, model) ->
    this.controllerFor('users').set 'content', Sks.User.all()
    this.controllerFor('currentUser').set 'content', Sks.CurrentUser.find(1)
    this.controllerFor('top').set 'content', Sks.Top.all()
    this.controllerFor('hamsters').set 'content', Sks.Hamster.all()