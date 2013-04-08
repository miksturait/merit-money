Sks.IndexRoute = Ember.Route.extend
  redirect: ->
    this.transitionTo 'users'