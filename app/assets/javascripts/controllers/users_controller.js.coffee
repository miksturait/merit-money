Sks.UsersController = Ember.ArrayController.extend
  needs: ['application', 'top', 'hamsters']
  sortProperties: ['lastName']
  sortAscending: true