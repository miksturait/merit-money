App.UsersController = Ember.ArrayController.extend
  needs: ['application', 'top', 'hamsters', 'user']
  statusBinding: 'controllers.application.status'
  activeRow: null

  setActiveRow: (id) ->
    @set 'activeRow', id