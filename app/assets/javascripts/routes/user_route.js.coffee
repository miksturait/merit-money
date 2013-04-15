Sks.UserRoute = Ember.Route.extend
  setupController: (controller, model) ->
    this.controllerFor('currentUser').set 'content', Sks.CurrentUser.find 1