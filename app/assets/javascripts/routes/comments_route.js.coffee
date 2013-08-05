App.CommentsRoute = Ember.Route.extend
  setupController: ->
    @controllerFor('myComments').set 'content', App.MyComment.all()
    @controllerFor('otherComments').set 'content', App.OtherComment.all()
    @controllerFor('currentUser').set 'content', App.CurrentUser.find(1)

  renderTemplate: ->
    @render 'dashboard',
      into: 'application'
      outlet: 'dashboard'
      controller: 'currentUser'

    @render 'comments',
      into: 'application'
      outlet: 'main'
      controller: 'comments'