Sks.UsersController = Ember.ArrayController.extend
  needs: ['application', 'top']
  sortProperties: ['lastName']
  sortAscending: true