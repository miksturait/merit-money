App.ApplicationRoute = Ember.Route.extend
  setupController: ->
    @controllerFor('users').set 'content', App.User.find()
    @controllerFor('currentUser').set 'content', App.CurrentUser.find(1)
    @controllerFor('top').set 'content', App.Top.find()
    @controllerFor('hamsters').set 'content', App.Hamster.find()
    @controllerFor('myComments').set 'content', App.MyComment.find()
    @controllerFor('otherComments').set 'content', App.OtherComment.find()