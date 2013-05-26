Sks.CommentsRoute = Ember.Route.extend
  setupController: (controller, model) ->
    @controllerFor('myComments').set 'content', Sks.MyComment.find()
    @controllerFor('otherComments').set 'content', Sks.OtherComment.find()
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