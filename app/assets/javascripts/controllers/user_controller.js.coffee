App.UserController = Ember.ObjectController.extend
  needs: ['users', 'application']

  toggleRow: ->
    @toggleProperty 'isExpanded'
    @get('controllers.users').send 'setActiveUser', @get 'id'