Sks.CommentsRoute = Ember.Route.extend
  setupController: ->
    @controllerFor('myComments').set 'content', Sks.MyComment.all()
    @controllerFor('otherComments').set 'content', Sks.OtherComment.all()
    @controllerFor('currentUser').set 'content', Sks.CurrentUser.find(1)

  renderTemplate: ->
    @render 'dashboard',
      into: 'application'
      outlet: 'dashboard'
      controller: 'currentUser'

    @render 'comments',
      into: 'application'
      outlet: 'main'
      controller: 'comments'