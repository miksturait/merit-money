Sks.ApplicationRoute = Ember.Route.extend
  setupController: ->
    @controllerFor('users').set 'content', Sks.User.find()
    @controllerFor('currentUser').set 'content', Sks.CurrentUser.find(1)
    @controllerFor('top').set 'content', Sks.Top.find()
    @controllerFor('hamsters').set 'content', Sks.Hamster.find()
    @controllerFor('myComments').set 'content', Sks.MyComment.find()
    @controllerFor('otherComments').set 'content', Sks.OtherComment.find()