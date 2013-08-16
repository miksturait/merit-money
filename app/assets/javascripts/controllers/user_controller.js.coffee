App.UserController = Ember.ObjectController.extend
  needs: ['users']
  isActive: false
  activeRow: null
  activeRowBinding: 'controllers.users.activeRow'

  activeRowObserver: (->
    isActive = @get('id') is @get('activeRow')
    @set 'isActive', isActive
  ).observes('activeRow')