App.UsersController = Ember.ArrayController.extend
  needs: ['application', 'top', 'hamsters']
  statusBinding: 'controllers.application.status'