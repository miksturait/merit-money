Sks.UsersController = Ember.ArrayController.extend
  needs: ['currentUser', 'kudo', 'top', 'hamsters']
  sortProperties: ['lastName']
  sortAscending: true