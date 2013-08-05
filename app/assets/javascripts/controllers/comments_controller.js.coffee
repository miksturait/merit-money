App.CommentsController = Ember.ArrayController.extend
  needs: ['myComments', 'otherComments']