Sks.UserRoute = Ember.Route.extend
  model:  (params) ->
    Sks.User.find params.user_id

  setupController: (controller, model) ->
    this.controllerFor('currentUser').set 'content', Sks.CurrentUser.find 1