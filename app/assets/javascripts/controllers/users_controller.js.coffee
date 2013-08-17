App.UsersController = Ember.ArrayController.extend
  needs: ['application', 'top', 'hamsters', 'user']
  statusBinding: 'controllers.application.status'
  activeUser: null

  setActiveUser: (userId) -> @set 'activeUser', userId

  activeUserObserver: (->
    self = @
    if @get('activeUser')?
      content = @get 'content'
      filteredContent = content.filter (user) -> user.get('id') isnt self.get('activeUser')
      filteredContent.forEach (user) -> user.set 'isExpanded', false
  ).observes('activeUser')