Sks.UsersController = Ember.ArrayController.extend
  needs: ['currentUser', 'kudo', 'top']
  sortProperties: ['lastName']
  sortAscending: true