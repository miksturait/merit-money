Sks.IndexRoute = Ember.Route.extend
  setupController: (controller, model) ->
    this.controllerFor('users').set 'content', Sks.User.find()
    this.controllerFor('currentUser').set 'content', Sks.CurrentUser.find 1
    this.controllerFor('top').set 'content', Sks.Top.find()