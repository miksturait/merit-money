Sks.UsersController = Ember.ArrayController.extend
  needs: ['kudo', 'top', 'hamsters']
  sortProperties: ['lastName']
  sortAscending: true